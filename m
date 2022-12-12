Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84553B9
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 19:27:35 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 71C185C0166;
	Mon, 12 Dec 2022 14:27:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 12 Dec 2022 14:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670873254; x=
	1670959654; bh=exWHAWwbYw1Bb1eFtcGCFsCsvBFkoqsMNHuVTDWR5g8=; b=V
	LT0U9Owslwx50X9NbYuMBXffRQXvzccRA1BbRsIdCem9AbVHo5frmj77UqzSTIaF
	tBETkl5cG76Te7mxmIPgqer3tO+mt/yAutrROhl+KOow1eTNRN4odRfuG8Plz6o0
	Kdhdqg4OEg+hLUBOPX1Oqnr2kn0/jTdnXQA4spEqf2r2JjfhX7gunT8J0qj+OHdG
	B7cO+z/5Y5CIBNcvkdzDczwL9jdg4Vom0H0g8Wnlnj7fN3XGZSNY0bZy1Zg2loFK
	5QLsaDzyTs09frF2bU/mwnrme2hi2iGPYTZCptHyhAVOR2bh6InTv3BQyt5hXPeV
	BEN40df6OFb580xtma8gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1670873254; x=1670959654; bh=e
	xWHAWwbYw1Bb1eFtcGCFsCsvBFkoqsMNHuVTDWR5g8=; b=A2g4klBAzER1ijLCE
	7x5O6KLE+dAdOKmme95qg2kJ5eqXb7m4GzQJNR3Nd9XWwnn+rhOsylWFKqtpMC9B
	pK6NQQUQwPCTm8aL1EoPC4hLeSeawk25zaybeTkrlPBd1cNTpR8bKa7A3CEOdUZK
	MzG0wNZxR5CWIxnSzkiTa1x+o0Vqc9D5pTy9Fr1GAF90SzDuleFtaX9WK9rdMkc9
	OEKnZl0Jjol+cKSPXU9wiOK123cQojIL1f9Weh3C3StO8YBht2A4+zsdtlbs57ZV
	W5l6igDPww4RmYi25JFxCiaaGGBC5m16t+wmWS1SdpgSp2+HLKgKBxzQNF1xRBa7
	bb5/w==
X-ME-Sender: <xms:poCXY64h1V_md6FkNdmMoAQvdsV7dOrdHAnfTaJ--jJxghvyiJ6ktg>
    <xme:poCXYz7HX4LUw8Ie5oaGR-__Li4Zo1iWfvXBcYq0UwOb2hRxgdbIyCNtf1_FmXU0V
    T3YDPFKWb7UPShO>
X-ME-Received: <xmr:poCXY5fhUfiWQEzMGW0v9lqgHOhEC8KBjP0KJaq67nvQv6Bdzl7b-nnkcpZxVCjq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuehruhhn
    ohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevhfffgfeuvdehhfehheehkeettdfgueehffdvvdejudelhfethefgleej
    feeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:poCXY3IjonkyXAXz3sxvsdCCO-g6TaZvpr6BWhgbEELM071jWpMswg>
    <xmx:poCXY-JHPTtf4WlWDEmn1_u_F03oUN78PHCrdNr_SPRDlkZhp5ViFQ>
    <xmx:poCXY4xD6wh1P21UDiC56xOPGGZfGDZA3jhDNxK0A_GAo1SYet_SNg>
    <xmx:poCXYwhru2qMHxpITLNguCIEZgDJnSxzql6PzzGK4C-W0qQvwwXcJQ>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 14:27:34 -0500 (EST)
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
Date: Mon, 12 Dec 2022 14:27:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, Denis.

> And can you elaborate what 'hangs' mean?  If there are no networks, then you should see a "No networks available" print or something similar.

By "hangs" I mean that when I run "station wlan0 scan", the command never returns. I work in a hospital office where there are _many_ wifi networks within range, including ones with strong signal. 

(iw is able to show me the available networks, and I can connect to them using wpa_supplicant. A different linux machine that uses NetworkManager with wpa_supplicant backend also shows me numerous networks. iwd--up to and including version 1.29--is also able to show me the available networks.)

> Can you run a few scans manually using 'station foo scan'?

First attempt never returns, as I mentioned above. Subsequent manual attempts, no matter how long I wait, all go like this:

$ sudo iwctl station wlan0 scan
Operation already in progress

Attempts to display networks using "station wlan0 get-networks" consistently results in "No networks available", which is not true.

-Bruno
