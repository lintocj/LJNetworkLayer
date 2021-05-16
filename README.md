# LJNetworkLayer
A generic network layer in iOS with Swift 5 using protocol programming. This is an easy setup for networking in iOS without any third party framework. Helps you make GET, POST, DELETE, PUT, etc calls and decode the JSON response to required model type without too much of boilerplate code.



* Installation Guide for LJNetworkLayer

You want to add pod 'LJNetworkLayer', '~> 1.8' similar to the following to your Podfile:

target 'MyApp' do
  pod 'LJNetworkLayer', '~> 1.8'
end

Then run a pod install inside your terminal, or from CocoaPods.app.

Alternatively to give it a test run, run the command:

pod try LJNetworkLayer
