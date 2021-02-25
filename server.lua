ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_job_center:setjob')
AddEventHandler('esx_job_center:setjob', function(job, label)
  local xPlayer = ESX.GetPlayerFromId(source) 
  xPlayer.setJob(job, 0)
  TriggerClientEvent('esx_notify:send', source, 'ROZPOCZĄŁEŚ PRACĘ <span style="color: #EE00FF;">'..label..'</span>', 'success')
end)