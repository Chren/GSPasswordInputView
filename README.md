# GSPasswordInputView
GSPasswordInputView is a wechat payment like password input view.

![GSPasswordInputView](https://raw.githubusercontent.com/Chren/GSPasswordInputView/master/GSPasswordInputViewExample/ScreenShot/screenshot.jpg)

## Howto Install
### Install with CocoaPods
[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
platform :ios, '7.0'
pod 'GSPasswordInputView'
```
## Usage
- Storyboard
```
  Drag an UIView to your storyboard, set its class to GSPasswordInputView.
  That's it!
```

- Create from code
```
  GSPasswordInputView *pwdInputView = [[GSPasswordInputView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
  pwdInputView.numberOfDigit = 6;
  [self.view addSubview:pwdInputView];
```
- Delegate
  Implement delegate below to get called when input complete;
```
  - (void)didFinishEditingWithInputView:(GSPasswordInputView *)anInputView text:(NSString *)aText;
```

## Requirements

- iOS7.0 (>=)
- ARC

## License
GSPasswordInputView is released under the MIT license. See LICENSE for details.
