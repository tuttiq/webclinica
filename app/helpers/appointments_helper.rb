module AppointmentsHelper
  def today_appointments(doctor)
    current_apps = doctor.agenda.appointments.with_status(:pending, :pacient_arrived, :on_going)
    current_apps.select{ |ap| ap.scheduled_at <= 2.hours.from_now && ap.scheduled_at >= 2.hours.ago }
  end

  def icon_for_status(status)
    case status
    when 'pending'
      image_tag('appointment_pending.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'pacient_arrived'
      image_tag('pacient_arrived.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'on_going'
      image_tag('appointment_ongoing.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'finished'
      image_tag('appointment_finished.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'pacient_absent'
      image_tag('pacient_absent.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    else
      "alo"
    end
  end
end