//
//  FAQ.swift
//  virtual solar UI
//
//  Created by 陈祉卓 on 2025/5/6.
//
import SwiftUI

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    var isExpanded: Bool = false
}

struct FAQView: View {
    @Environment(\.dismiss) var dismiss
    @State private var faqs = [
        FAQItem(question: "FAQ 1", answer: "IT guys – get the text/copy from website"),
        FAQItem(question: "FAQ 2", answer: "Answer for FAQ 2"),
        FAQItem(question: "FAQ 3", answer: "Answer for FAQ 3"),
        FAQItem(question: "FAQ 4", answer: "Answer for FAQ 4"),
        FAQItem(question: "FAQ 5", answer: "Answer for FAQ 5")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 20) {
                    // ✅ Logo at the top
                    HStack {
                        Spacer()
                        Image("SolarCloudLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 60)
                        Spacer()
                    }
                    .padding(.top)

                    // ✅ Back button + FAQ Title
                    HStack(spacing: 10) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(Color("AccentColor2"))
                        }

                        Text("FAQ")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.horizontal)

                    // ✅ FAQ List
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(faqs.indices, id: \.self) { index in
                                FAQCard(faq: $faqs[index])
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct FAQCard: View {
    @Binding var faq: FAQItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(faq.question)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: faq.isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            faq.isExpanded.toggle()
                        }
                    }
            }

            if faq.isExpanded {
                Text(faq.answer)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background(Color("AccentColor5"))
        .cornerRadius(12)
    }
}

#Preview {
    FAQView()
}
