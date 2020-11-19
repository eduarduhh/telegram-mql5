#property copyright "EDUARDO COSTA CARVALHO"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Telegram.mqh>

CCustomBot    bot;      // BOT TELEGRAM


/********************************
 * CONFIGURAÇÃO TELEGRAM        *
 * 
******************************/
string id_telegram = "000000"; // //ID do Canal
string Token       = "00000"; // Chave do bot
//--------------------------------------------------------------------------------------


int OnInit(){ 
   
   //Removendo todos indicadores na tela
    RemoverIndicadores();
   //Mensagem inicial do Robo 
   mensagem();
   //2 segunsos
   Sleep(2000); 
   print();
   
   return(INIT_SUCCEEDED);
}
   
//FUNCAO DE SAIR
void OnDeinit(const int reason){
   RemoverIndicadores();
}

//FUNCAO TICK A CADA TICK DO MERCADO
void OnTick(){
 
  
} 

void RemoverIndicadores(){

//Remove todos os indicadores do grafico
   int subwindows =ChartGetInteger(0,CHART_WINDOWS_TOTAL);

   for(int i=subwindows;i>=0;i--)
   {
      int indicators=ChartIndicatorsTotal(0,i);

      for(int j=indicators-1; j>=0; j--)
      {
         ChartIndicatorDelete(0,i,ChartIndicatorName(0,i,j));
      }
   }
 }
 
void print(){
   
  bot.Token(Token);
  
  //Print da Tela
  ChartScreenShot(0,"Print.png",400,400,ALIGN_CENTER);
     
   string photo_id;
   
   int result=bot.SendPhoto(photo_id, id_telegram,"Print.png");
      if(result==0)
         Print("Photo ID: ",photo_id);
      else
         Print("Error: ",GetErrorDescription(result));
 }
 
 void mensagem(){
   bot.Token(Token);
   bot.XSendMessage(id_telegram, ":::======== RSI ALERTA ========:::"
                                 +"\n" + "Período: "  + Period()
                                 +"\n" + "Simbolo: " +Symbol()  
                                 +"\n" + TimeCurrent()
                                 +"\n" + ":::===========================:::" 
                   );
   
 
 }
