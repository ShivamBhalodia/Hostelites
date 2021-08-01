from django.shortcuts import render
from rest_framework.response import Response
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from account.serializers import RegisterSerializer
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.decorators import api_view
import io
from django.contrib.auth import login
from account.models import User,PhoneOTP
from account.serializers import CreateUserSerializer,LoginUserSerializer
from django.core.mail import send_mail
##from blissedmaths.utils import phone_validator, password_generator, otp_generator
import math,random
# Create your views here.
@csrf_exempt
@api_view(["POST"])
def register(request):

    serializer=RegisterSerializer(data=request.data)

    if serializer.is_valid():


        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    return Response(serializer.errors)
def otp_generator() : 
   
    digits = "0123456789"
    OTP = "" 
    for i in range(4) : 
        OTP += digits[math.floor(random.random() * 10)] 
  
    return OTP 

def send_otp(phone):
    """
    This is an helper function to send otp to session stored phones or 
    passed phone number as argument.
    """

    if phone:
        
        key = otp_generator()
        phone = str(phone)
        otp_key = str(key)

        #link = f'https://2factor.in/API/R1/?module=TRANS_SMS&apikey=fc9e5177-b3e7-11e8-a895-0200cd936042&to={phone}&from=wisfrg&templatename=wisfrags&var1={otp_key}'
   
        #result = requests.get(link, verify=False)

        return otp_key
    else:
        return False

def sendotp_email(email):

    if email:
            key = otp_generator()
            email = str(email)
            otp_key = str(key)
            # subject = 'Please Confirm Your Account'
            # message = 'Your 4 Digit Verification Pin: {}'.format(otp_key)
            # email_from = '*****'
            # recipient_list = [str(emaill), ]
            # send_mail(subject, message, email_from, recipient_list)
            return otp_key
    else:
        return False



@api_view(["POST"])
@csrf_exempt
def ValidatePhoneSendOTP(request):
    '''
    This class view takes phone number and if it doesn't exists already then it sends otp for
    first coming phone numbers'''

    
    phone_number = request.data.get('phone')
    print(phone_number)
    val=1
    if phone_number:
        username=phone
        val=0
    else:
        username=request.data.get('email')
    if username:
            username = str(username)
            user = User.objects.filter(username = username)
            if user.exists():
                return Response({'status': False, 'detail': 'User already exists'})
                 # logic to send the otp and store the phone number and that otp in table. 
            else:
                if val==0:
                    otp = send_otp(username)
                else:
                    otp=sendotp_email(username)
                print(username, otp)
                if otp:
                    otp = str(otp)
                    count = 0
                    old = PhoneOTP.objects.filter(username = username)
                    if old.exists():
                        count = old.first().count
                        old.first().count = count + 1
                        old.first().save()
                    
                    else:
                        count = count + 1
               
                        PhoneOTP.objects.create(
                             username =  username, 
                             otp =   otp,
                             count = count
        
                             )
                    if count > 7:
                        return Response({
                            'status' : False, 
                             'detail' : 'Maximum otp limits reached. Kindly support our customer care or try with different number'
                        })
                    
                    
                else:
                    return Response({
                                'status': 'False', 'detail' : "OTP sending error. Please try after some time."
                            })

                return Response({
                    'status': True, 'detail': 'Otp has been sent successfully.'
                })
    else:
            return Response({
                'status': 'False', 'detail' : "I haven't received any phone number/e-mail. Please do a POST request."
            })

@api_view(["POST"])
@csrf_exempt
def ValidateOTP(request):
    '''
    If you have received otp, post a request with phone and that otp and you will be redirected to set the password
    
    '''

    
    phone = request.data.get('phone', False)
    if phone:
        username=phone
    else:
        username=request.data.get('email',False)
    otp_sent   = request.data.get('otp_sent', False)
    print(username,otp_sent)
    if username and otp_sent:
            old = PhoneOTP.objects.filter(username = username)
            if old.exists():
                old = old.first()
                otp = old.otp
                if str(otp) == str(otp_sent):
                    old.logged = True
                    old.save()

                    return Response({
                        'status' : True, 
                        'detail' : 'OTP matched, kindly proceed to save password'
                    })
                else:
                    return Response({
                        'status' : False, 
                        'detail' : 'OTP incorrect, please try again'
                    })
            else:
                return Response({
                    'status' : False,
                    'detail' : 'Phone/E-mail not recognised. Kindly request a new otp with this number/e-mail'
                })


    else:
            return Response({
                'status' : 'False',
                'detail' : 'Either phone/emaail or otp was not recieved in Post request'
            })

@api_view(["POST"])
@csrf_exempt
def Register(request):

    '''Takes phone and a password and creates a new user only if otp was verified and phone is new'''

    
    serializer=RegisterSerializer(data=request.data)
    if serializer.is_valid:
            phone=request.data.get('phone',False)
            if phone:
                username=phone
            else:
                username=request.data.get('email',False)
            password=request.data.get('password',False)
           
            print(username)
            print(password)
                
            if username and password:
                    username = str(username)
                    user = User.objects.filter(username = username)
                    if user.exists():
                        return Response({'status': False, 'detail': 'Phone Number/E-mail  already have account associated. Kindly try forgot password'})
                    else:
                        old = PhoneOTP.objects.filter(username = username)
                        print(old)
                        if old.exists():
                            old = old.first()
                            if old.logged:
                                Temp_data = {'username': username, 'password': password }

                                serializer = CreateUserSerializer(data=Temp_data)
                                serializer.is_valid(raise_exception=True)
                                user = serializer.save()
                                user.save()

                                old.delete()
                                return Response({
                                    'status' : True, 
                                    'detail' : 'Congrts, user has been created successfully.'
                                })

                            else:
                                return Response({
                                    'status': False,
                                    'detail': 'Your otp was not verified earlier. Please go back and verify otp'

                                })
                        else:
                            return Response({
                            'status' : False,
                            'detail' : 'Phone number/E-mail not recognised. Kindly request a new otp with this number/e-mail'
                        })
                            




            else:
                    return Response({
                        'status' : 'False',
                        'detail' : 'Either phone/e-mail or password was not recieved in Post request'
                    })
        


@api_view(["POST"])
# @permission_classes([permissions.AllowAny,])
@csrf_exempt
def Login(request):
        
        serializer = LoginUserSerializer(data=request.data)
        if serializer.is_valid():
        
            user = serializer.validated_data['user']
                
            login(request, user)
            return Response({
                    'status' : 'True',
                                'detail' : 'user logged in successfully'

                })
        else:
                return Response({
                    'status' : 'False',
                                'detail' : 'Incorrect credentials'

                })
