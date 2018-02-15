Pod::Spec.new do |s|

  s.name         = "Iobfs4proxy"
  s.version      = "1.0.2"
  s.summary      = "iObfs is an iOS build of obfs4proxy for use inside Tor apps, such as Onion Browser and iCepa"
  s.description  = <<-DESC
iObfs is an iOS build of obfs4proxy for use inside Tor apps, such as Onion Browser and iCepa.

obfs4proxy is a pluggable transport for Tor, which can allow users to defeat certain types of network censorship. (Read some great information about pluggable transports — and how they work — here and here.)

This work is supported in part by The Guardian Project.                   
                   DESC
  s.homepage     = "https://github.com/ynd-consult-ug/iObfs"
  s.license      = { :type => 'BSD 2', :text => '
    Copyright (c) 2016, Mike Tigas <mike at tig dot as>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

  ' }
  s.author       = { "Mike Tigas" => "https://mike.tig.as/" }
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :http => "https://github.com/ynd-consult-ug/iObfs/releases/download/1.0.2/Iobfs4proxy.framework.zip" }  
  s.vendored_frameworks = 'Iobfs4proxy.framework'
end
