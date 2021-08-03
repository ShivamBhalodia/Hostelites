from django.contrib import admin
from account.models import PhoneOTP,Customer,Shopkeeper

admin.site.register(PhoneOTP)
admin.site.register(Customer)
admin.site.register(Shopkeeper)
##from account.models import User
# Register your models here.


# class UserAdmin(admin.ModelAdmin):
#     list_display=['Name','username']

# admin.site.register(User,UserAdmin)