class ActivityController < ApplicationController
    
    def progress
        @init=0
        
        if params[:asignature_id] != "0"
            @init=1
            activities=Activity.where(asignature_id:params[:asignature_id])
            nota=0
            faltante=3.0
            activities.each do |c| 
                if(c.advance == 100 && c.note >= 0)
                    nota=nota+(c.note*(c.value.to_f/100))
                end
            end
            @notaS=nota
            @faltanteS= faltante-nota
            #puts nota
            #puts faltante
        else
            @init=1
            @not="0"
            redirect_to "/activity/progress", :flash => {:alert => "Debes seleccionar una asignatura"}
        end
    end
    def resume
    end
    def addProgress
        if params[:activitie_id] == "0" ||  params[:asignature_id] == "0" 
            redirect_to "/activity/progress", :flash => {:alert => "Debes seleccionar una asignatura y una actividad"}
        else
            if params[:percenAv].blank?
                redirect_to "/activity/progress", :flash => {:alert => "Ingresa un porcentaje entre el 1 y el 100"}
            else
                if params[:percenAv].to_i >= 0 && params[:percenAv].to_i <=100
                    activityactual=Activity.find(params[:activitie_id])
                    advance=activityactual.advance.to_i
                    if advance+params[:percenAv].to_i <=100
                        activityactual.update(advance:advance+params[:percenAv].to_i)
                        redirect_to "/activity/progress", :flash => {:alert => "Avance añadido"}
                    else
                        redirect_to "/activity/progress", :flash => {:alert => "Superas el 100%"}
                    end
                else
                    redirect_to "/activity/progress", :flash => {:alert => "Ingresa un porcentaje entre el 1 y el 100"}
                end
            end
        end
    end
   

end
