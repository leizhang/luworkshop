from django.contrib import admin
from .models import User, SLCStaff, Ethnicities, PeopleSoftExtract, WorkshopCategory, WorkshopTitle, Workshop, RegisrationDate, Registration, Appointment, TblDropIns, WorkshopAttendance, OtherTeaching, WorkStaffedBy

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    pass

@admin.register(SLCStaff)
class SLCStaffAdmin(admin.ModelAdmin):
    pass

@admin.register(Ethnicities)
class EthnicitiesAdmin(admin.ModelAdmin):
    pass

@admin.register(PeopleSoftExtract)
class PeopleSoftExtractAdmin(admin.ModelAdmin):
    pass

@admin.register(WorkshopCategory)
class WorkshopCategoryAdmin(admin.ModelAdmin):
    pass

@admin.register(WorkshopTitle)
class WorkshopTitleAdmin(admin.ModelAdmin):
    pass

@admin.register(Workshop)
class WorkshopAdmin(admin.ModelAdmin):
    pass

@admin.register(RegisrationDate)
class RegisrationDateAdmin(admin.ModelAdmin):
    pass

@admin.register(Registration)
class RegistrationAdmin(admin.ModelAdmin):
    pass

@admin.register(Appointment)
class AppointmentAdmin(admin.ModelAdmin):
    pass

@admin.register(TblDropIns)
class TblDropInsAdmin(admin.ModelAdmin):
    pass

@admin.register(WorkshopAttendance)
class WorkshopAttendanceAdmin(admin.ModelAdmin):
    pass

@admin.register(OtherTeaching)
class OtherTeachingAdmin(admin.ModelAdmin):
    pass

@admin.register(WorkStaffedBy)
class WorkStaffedByAdmin(admin.ModelAdmin):
    pass
