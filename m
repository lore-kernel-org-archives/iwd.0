Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E65CBC
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 14:42:23 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 162843200495;
	Tue, 13 Dec 2022 09:42:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 13 Dec 2022 09:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670942541; x=
	1671028941; bh=NcNYqJb4SP0H7VWOvTZ1nhtYLr1fsBdDVkDi7UdrBX8=; b=E
	aGUdYBSzou3DKQTGYzl+6B7w0vzsfcUdJK44kAdQjT1GXCiIMiO7KmcUSmYULbHF
	3mobYccFKV+ELIOSoJ61Tde5riWDmSED7NOnMR3O0V/C3yuyqXbX+cWWqErC629B
	MjrO2CHPnaNyc0uz07pt/4IqAIv+DP+ZREcmSNWr0WI4CKpmacKwq7CgMvKa9c9F
	RJr/5/OVKB7VNbPg9p7Oja4umlLiZM1scvnKf8HcJ1yn52454jCWPNZOI2XQhuXW
	yY79xdb/j0O0Y+uDoNwgee2ngvOf8xjZmLv/3XtnQsJEBJeqbRa+1qy8Z2r0aF19
	WShaxJsRTgi9tTO3ELSJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670942541; x=
	1671028941; bh=NcNYqJb4SP0H7VWOvTZ1nhtYLr1fsBdDVkDi7UdrBX8=; b=H
	/Yc25QtSkkMejQRsHrDs8qiP16hXSjDmrNs9OdUQbzZjVIN4qlp9SDBFKXtLXdKW
	Ki+zBRktmjwLoSuJeaD+M9gulg3ODlX2klLeAeQxJdcN4zFVNid8aWUW4LXfsbGv
	HlZHlMuP/mxa6nmSyvJ7DxBSzW5/zg6dm6f13vbGAJHeYpzVIgyjVQIC6vx16Mlj
	ZBUNISwwm3rPOX7aKOPwhkaxcxDmIf+VaHWr3iz94HXWaAVqQKOG62NDRQoB3XBe
	zBV2N3DXU7j1wdh1NVPLSMlqpqlR7GOWHpQt/f/WJAOcofqBhZR+0tpKGJnT87ep
	OaElO1L0W5kECsVb+Ggkg==
X-ME-Sender: <xms:TY-YY5Ja2apB84jkNGEBrZBUrVYkIslk7ESOSSAp7hhh7X2Q_PjFkA>
    <xme:TY-YY1LYeGg3vfZNzBsxNZdxNG6bYBnk_0Xjp7_LnqUz1csUR1rBNIRQw3DNAExm2
    UmVB9fRpO3aG1I0>
X-ME-Received: <xmr:TY-YYxsfxowiDqzItMwUBCKekXMA16A2gqxBrY04P9PYYfkZL4h4I3Hk6XuBD1vUCl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfvefhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuehruhhn
    ohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtffrrg
    htthgvrhhnpedtheevgeeiteehgfetkefhleeftdejheffheeuhfffgeduveeffeelgffh
    tedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:TY-YY6bsFEy66ZHoYdnGclpHRoEzLp-b49Da8WFV5GBIi3fF0r0JBw>
    <xmx:TY-YYwar0YqlRm1eyZuLLDXAgaK1dINVX-8XlljQgHVYUDnS3XkT2w>
    <xmx:TY-YY-DRW9linZ4tEBTzxROOp4Njr0i7NPacsKkOUlJhFkYaPJ6WrA>
    <xmx:TY-YY_nS6ExT1jxLweKVffQ8N2Y1iKv8JJaCQYlOZuh_kE3bQheQ8A>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 09:42:20 -0500 (EST)
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
 <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
Cc: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <615ceb63-e041-1990-81fa-568181681aa7@airpost.net>
Date: Tue, 13 Dec 2022 09:42:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, Alvin. 

Thank you for looking into this issue. 

I just wanted to report that latest commit (ed357d78b3c70c43b37ec9444f5c96f14e14eb88) has not solved the bug I'm experiencing. "station wlan0 scan" continues to either hang indefinitely or say "Operation already in progress". "station wlan0 get-networks" continues to claim that no networks are available, which is not true. This behavior unfortunately makes iwd unusable in my place of work.

If you guys need any further information or debug logs to solve this, please let me know and I'll be happy to help.

Cheers,
Bruno
