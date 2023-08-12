//
//  ContentView.swift
//  RockPaper
//
//  Created by Ankit Kaushik on 14/05/23.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}

struct ContentView: View {
    @State var longString = """
    -> This is a Single player game
    -> The player will be given five chances
    -> For every winning they will be given a point
    -> If its a draw then no chance will be counted
    -> The player who gets maximum score after 5 Perfect chances Wins the game
    -> There are three buttons in the game named Rock,Paper and Scissor
    -> Any one of them is correct
    """
        
    @State var pressed=false
    func rules(){
        pressed=true
    }
    var body:some View{
        NavigationView{
            VStack{
                
                ZStack{
                        Image("sci")
                        .resizable()
                        .ignoresSafeArea()
                    NavigationLink(destination:gamestart()){
                        ZStack{
                            GifImage("Startgame")
                                .frame(width:435,height:225)
                        }
                    }
                }
                Spacer(minLength:1)
                Button("CLICK HERE->RULES",action:rules)
                    .foregroundColor(.red)
                    .bold()
                    .font(.title)
                    .alert("RULES", isPresented:$pressed){
                        
                    }message: {
                        Text("\(longString)".uppercased())
                    }
            }
        }
    }
}
struct gamestart: View{
    @State var values=["Rock🪨🪨","Paper📝📝","Scissor✂️✂️"].shuffled()
    @State var initial=""
    @State var correctanswer=Int.random(in:0...2)
        
    @State var won=false
    @State var Player=0
    @State var title=""
    @State var Opponent=0
    @State var showscore=false
    @State var turn=0
    @State var score=0
    @State var over=false
    @State var showsheet=false;
    @State var chances=5
    @State var game2 = "Game Over!!"
    @State var text="Start Game".uppercased()
    func gamestart(){
        showsheet=true
    }
    func taped(_ number:Int){
        if(values[number]=="Paper📝📝"&&values[correctanswer]=="Rock🪨🪨"){
            title="You Won!!🥳🥳"
            Player=Player+1
            chances=chances-1
            
        }
        else if(values[number]=="Rock🪨🪨"&&values[correctanswer]=="Scissor✂️✂️"){
            title="You Won!!🥳🥳"
            Player=Player+1
            chances=chances-1
        }
        else if(values[number]=="Scissor✂️✂️"&&values[correctanswer]=="Paper📝📝"){
            title="You Won!!🥳🥳"
            Player=Player+1
            chances=chances-1
        }
        else if(values[number]==values[correctanswer]){
            title="Its a draw!!😃😃"
        }
        else{
            title="Lose!!😱😱"
            Opponent=Opponent+1
            chances=chances-1
        }
        if(chances==0){
            if(Player>Opponent){
                title="Congrats You Won!!🥇🏆".uppercased()
            }
            else{
                title="Better Luck Next Time!!🥹🥹".uppercased()
            }
        }
        showscore=true
    }
    func reset1(){
        chances=5
        Player=0
        Opponent=0
    }
    func ask(){
        correctanswer=Int.random(in: 0...2)
        values.shuffle()
    }
    var body: some View {
        VStack{
            ZStack{
                NavigationView{
                    VStack{
                        ZStack{
                            Image("neon")
                                .resizable()
                                .ignoresSafeArea()
                            VStack{
                                Spacer()
                                Section
                                {
                                    Text("Choose any of one three")
                                        .padding(10)
                                        .background(.green)
                                        .padding(5)
                                        .background(.white)
                                        .padding(10)
                                        .background(.orange)
                                        .foregroundColor(.black)
                                        .padding()
                                        .font(.title)
                                    Spacer()
                                    if(chances==0){
                                        Section{
                                            VStack(spacing:100){
                                                ForEach(0..<3){ number in
                                                    Button{
                                                        taped(number)
                                                    }label: {
                                                        Text("\(values[number])")
                                                            .padding(10)
                                                            .background(.mint)
                                                            .padding(5)
                                                            .background(.black)
                                                            .padding(10)
                                                            .background(.pink)
                                                            .foregroundColor(.black)
                                                            .padding()
                                                            .font(.title)
                                                        
                                                    }
                                                }
                                            }
                                            .alert(title, isPresented:$showscore){
                                                Button("Reset",action:reset1)
                                            }message: {
                                                Text("Opponent Choose \(values[correctanswer])")
                                            }
                                        }
                                    }
                                    else{
                                        Section{
                                            VStack(spacing:100){
                                                ForEach(0..<3){ number in
                                                    Button{
                                                        taped(number)
                                                    }label: {
                                                        Text("\(values[number])")
                                                            .padding(10)
                                                            .background(.mint)
                                                            .padding(5)
                                                            .background(.black)
                                                            .padding(10)
                                                            .background(.pink)
                                                            .foregroundColor(.black)
                                                            .padding()
                                                            .font(.title)
                                                        
                                                    }
                                                }
                                            }
                                            .alert(title, isPresented:$showscore){
                                                Button("Continue",action:ask)
                                            }message: {
                                                Text("Opponent Choose \(values[correctanswer])")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
            Text("Your Score-> \(Player)     Opponent Score-> \(Opponent)     Chances Left-> \(chances)".uppercased())
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
