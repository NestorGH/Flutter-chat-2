abstract class DataUtils{
  static String getUserImage(String user){
    if (user  == 'nestor'){
      return '';
    }
    return _getImageUrl(user);
  }

  static String getChannelImage() => _getImageUrl('https://ih1.redbubble.net/image.971714560.7196/st,small,507x507-pad,600x600,f8f8f8.jpg');

  static String _getImageUrl(String value) => 'https://img4.goodfon.com/wallpaper/nbig/7/e2/g2-esports-cs-go-league-of-legends-samurai.jpg';

}