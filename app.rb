require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/division")
require("./lib/employee")
require("pg")

get("/") do
  @divisions = Division.all()
  erb(:index)
end

get("/division_form") do
  @divisions = Division.all()
  erb(:division_form)
end

get("/employee_form") do
  @divisions = Division.all()
  erb(:employee_form)
end

get("/division_employees/:id") do
  @division = Division.find(params.fetch("id").to_i())
  erb(:division_employees)
end

post("/divisions") do
  name = params.fetch("name")
  division = Division.new({:name => name, :id => nil})
  division.save()
  @divisions = Division.all()
  erb(:index)
end

post('/employees') do
  name = params.fetch("name")
  division_id = params.fetch("division_id").to_i()
  employee = Employee.new({:name => name, :division_id => division_id})
  employee.save()
  @division = Division.find(division_id)
  @divisions = Division.all()
  erb(:index)
end

get '/divisions/:id/edit' do
  @divisions = Division.all()
  @division = Division.find(params.fetch("id").to_i())
  erb(:division_edit)
end

patch("/divisions/:id") do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({:name => name})
  @divisions = Division.all()
  erb(:index)
end

delete("/divisions/:id") do
  @division = Division.find(params.fetch("id").to_i())
  @division.delete()
  @divisions = Division.all()
  erb(:index)
end
