from django.db import models
from django.contrib.auth.models import User
from django.core.validators import RegexValidator
##from blissedmaths.utils import unique_otp_generator
# Create your models here


class PhoneOTP(models.Model):
    ##phone_regex = RegexValidator( regex   =r'^\+?1?\d{9,14}$', message ="Phone number must be entered in the format: '+999999999'. Up to 14 digits allowed.")
    username       = models.CharField(max_length=17, unique=True,default="")
    otp         = models.CharField(max_length = 9, blank = True, null= True)
    count       = models.IntegerField(default = 0, help_text = 'Number of otp sent')
    logged      = models.BooleanField(default = False, help_text = 'If otp verification got successful')
    forgot      = models.BooleanField(default = False, help_text = 'only true for forgot password')
    forgot_logged = models.BooleanField(default = False, help_text = 'Only true if validdate otp forgot get successful')




class Customer(models.Model):
    user1=models.OneToOneField(User,on_delete=models.CASCADE)
    loggedin_with=models.CharField(max_length=10)
    Name=models.CharField(max_length=100)
    email=models.EmailField(blank=True,null=True)
    phone=models.CharField(max_length=17,blank=True,null=True)
    address=models.TextField(blank=True,null=True)

class Shopkeeper(models.Model):
    user1= models.OneToOneField(User,on_delete=models.CASCADE)
    loggedin_with=models.CharField(max_length=10)
    Restaurant_name=models.CharField(max_length=100)
    Owner_name=models.CharField(max_length=100,blank=True,null=True)
    email=models.EmailField(blank=True,null=True)
    phone=models.CharField(max_length=17,blank=True,null=True)
    address=models.TextField(blank=True,null=True)
    Category=models.CharField(max_length=25,blank=True,null=True)


# class Items(models.Model):
#     user1=models.Foreignkey(Shopkeeper,on_delete=models.CASCADE)
#     Name=models.CharField(max_length=100)
#     Description=models.TextField()
#     Price=models.IntegerField()


