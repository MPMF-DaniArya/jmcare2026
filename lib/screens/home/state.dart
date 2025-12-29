
import 'package:carousel_slider/carousel_slider.dart';

class HomeState {

  CarouselSliderController? carouselController;

  String noKTP = "";
  String isDebitur = "";
  bool bSwitch = false;

  HomeState(){
    carouselController = CarouselSliderController();
  }
}