class AsignatureController < ApplicationController
    def index
        @Allactivities= Activity.where(note:nil).order(:sendDate)
        @Activitiesdel=Activity.where("note>=0").order(:sendDate)
    end 

    def gestion
        @Allasignatures=Asignature.all
    end
    def new
        
    end
    def create
        if params[:commit] == "Añadir"  
            if params[:codeAs].blank? | params[:nameAs].blank? | params[:creditAs].blank?
                if params[:codeAs].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Ingresa un codigo"}
                
                elsif params[:nameAs].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Ingresa un nombre"}
                
                elsif params[:creditAs].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Ingresa la cantidad de creditos"}
                end
            else
                if !Asignature.find_by(id:params[:codeAs]).nil?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "La asignatura ya existe"}
                else
                    Asignature.create(id:params[:codeAs],name:params[:nameAs],credits:params[:creditAs]);
                    redirect_to "/asignature/gestion"
                    
                end
            end
        else
            if !params[:codeAs].blank?
                asignatureActual=Asignature.find(params[:codeAs]);
                output=0
                if !params[:nameAs].blank?
                    asignatureActual.update(name:params[:nameAs])
                    output=output+1
                end
                if !params[:creditAs].blank?
                    asignatureActual.update(credits:params[:creditAs])
                    output=output+2
                end
                if output == 1
                    redirect_to "/asignature/gestion"
                end
                if output == 2
                    redirect_to "/asignature/gestion"
                end
                if output ==3
                    redirect_to "/asignature/gestion"
                end
            else
                redirect_to "/asignature/gestion", :flash =>{:alert => "Ingresa un codigo de materia para actualizar"}
            end
        end
    end
  
    def delete
        asignatureToDelete=Asignature.find(params[:asignature_id])
        if !asignatureToDelete.nil?
            Activity.where(asignature_id:params[:asignature_id]).each do |c|
                c.destroy
            end
            asignatureToDelete.destroy
            redirect_to "/asignature/gestion"
        else
            redirect_to "/asignature/gestion", :flash =>{:alert => "No se puede ejecutar la eliminacion"}
        end
    end

    def createActivity
        if params[:asignature_id] != "0"
            if params[:codeAc].blank? | params[:nameAc].blank? | params[:descriptionAc].blank? | params[:percenAc].blank? | params[:dateAc].blank? | params[:hourAc].blank?
                if params[:codeAc].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Debes asignar un codigo"}
                elsif params[:nameAc].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Debes asignar un nombre"}
                elsif params[:descriptionAc].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Debes asignar una descripcion"}
                elsif params[:percenAc].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Debes asignar un porcentaje de la materia"}
                elsif  params[:dateAc].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Debes asignar una fecha limite de entrega"}
                elsif  params[:hourAc].blank?
                    redirect_to "/asignature/gestion", :flash =>{:alert => "Debes asignar una hora limite de entrega"}
                end
            else 
                if !Asignature.find(params[:asignature_id]).nil?
                    if Activity.find_by(id:params[:codeAc]).nil?
                        if params[:percenAc].to_i<=100
                            porcentaje=0;
                            Activity.where(asignature_id:params[:asignature_id]).each do |c|
                                porcentaje=porcentaje+c.value
                            end
                            if porcentaje <= 100 && params[:percenAc].to_i+porcentaje<=100
                                Activity.create(id:params[:codeAc],name:params[:nameAc],description:params[:descriptionAc],value:params[:percenAc],sendDate:params[:dateAc],limitHour:params[:hourAc],asignature_id:params[:asignature_id],advance:0)
                                redirect_to "/asignature/gestion", :flash =>{:alert => "Actividad asignada"}
                            else
                                redirect_to "/asignature/gestion", :flash =>{:alert => "Al añadir la actividad se supera el 100% de la materia"}
                            end
                        elsif
                            redirect_to "/asignature/gestion", :flash =>{:alert => "El porcentaje no puede superar el 100%"}
                        end
                    else
                        redirect_to "/asignature/gestion", :flash =>{:alert => "La actividad ya se encuentra reistrada"}
                    end
                else
                    redirect_to "/asignature/gestion", :flash =>{:alert => "La materia no se encuentra registrada"}
                end
            end    
        else
            redirect_to "/asignature/gestion", :flash =>{:alert => "Primero debes seleccionar una asignatura"}
        end
    end
    def addNote
        activity = Activity.find(params[:activity_id])
        if !activity.nil?
            if params[:Note].to_f>= 0.0 && params[:Note].to_f<=5.0 && !params[:Note].blank? 
                activity.update(note:params[:Note].to_f,advance:100)
                redirect_to "/"
            else
                redirect_to "/asignature/index", :flash =>{:alert => "Ingrese la nota"}
            end
        end
    end
    def updateDate
        activity = Activity.find(params[:activity_id])
        if !activity.nil?
            if !params[:dateUp].blank?
                activity.update(sendDate:params[:dateUp])
                redirect_to "/"
            else
                redirect_to "/asignature/index", :flash =>{:alert => "Ingrese la fecha nueva"}
            end
        end
    end
    def deleteAll
        Activity.all.each do |c| 
            c.destroy
        end
        Asignature.all.each do |c|
            c.destroy
        end
        redirect_to "/asignature/gestion"

    end
end
