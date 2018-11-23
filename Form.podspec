
Pod::Spec.new do |s|
  s.name             = 'Form'
  s.version          = '0.1.0'
  s.summary          = 'Test summary'
 
  s.description      = <<-DESC
Test description
                       DESC
 
  s.homepage         = 'https://github.com/alexeypolitov/form-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexey Politov' => 'a.politov@dudes.team' }
  s.source           = { :git => 'https://github.com/alexeypolitov/form-ios.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'
  s.source_files = 'Form/Classes'
 
end
