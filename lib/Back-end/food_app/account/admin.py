from django.contrib import admin
from account.models import PhoneOTP

admin.site.register(PhoneOTP)
##from account.models import User
# Register your models here.


# class UserAdmin(admin.ModelAdmin):
#     list_display=['Name','username']

# admin.site.register(User,UserAdmin)