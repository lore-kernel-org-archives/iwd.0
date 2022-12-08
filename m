Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91370629
	for <iwd@lists.linux.dev>; Thu,  8 Dec 2022 05:18:52 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A9D175C00C1;
	Thu,  8 Dec 2022 00:18:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Dec 2022 00:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1670476731; x=1670563131; bh=i88vq7SoCT
	R0m2xKeHL9XBW/BsJ6O+7d113hntGUxXg=; b=gLHIkBd4Tz2Nqq/aAuIZtxYD3A
	ZILyZb4W7mQFXP8Uee+k4gXtSVwy6W2A+YN1maZmdr3KTA0eZGT26sOy5QRm9fQX
	y+SMbNPQ3uE6k9dXC3NMtN56DReUD9v39a0GLBt8Xmql5if5qL7p+etiDOh3FLuC
	lCW8IyAZRxJYC23BElejyc1ScpvLtGOVmFa4tuwvyBdAMfjinBVAIrCxOmyn7/V5
	XaaxdCu3dndbbSk/KNhj9DND5ePqr2ETNMepeiWKzklZ88ofJAZyMgMOF+lGp9/p
	pP0t49F3SDhF3CbFpg8mG2asGSx3mtSdSLutbtaQ87rqpFwCu+WqTPFZXNOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1670476731; x=1670563131; bh=i88vq7SoCTR0m2xKeHL9XBW/BsJ6
	O+7d113hntGUxXg=; b=lBUuYKsfssdbDt3/jDFatZXsCPFbKG4iBqwiUbRu3kwM
	7OLJrM/hSzC57UmxEL72kSn2Np9BucPDyHEeuj6NgIt14pX0zBHhypcBcutIkF0P
	S5EDGAStqzE2eCEXEU+lUljHq4MoHoa3LKI+qak/X2RD6n+u5YTO6/q5yL1IMaoh
	igxC/WubbOfNckvdwedJoJvzCpbvn3rDfxcdTWrzXZ9vRsF1pZCOtZnExF6t+GEC
	ZD3ykT1+QEWEwweeFyPIujz+WJxoYCedsZgIbBP5B/K8qv3ITq/dfalXv9Inesax
	7ur1N6QzTEpE+t/pcSVSnhPu7bsz3FCti1woxhkb4A==
X-ME-Sender: <xms:u3ORY6rL7QcjNdfQB5ogtaPVON4dxCnvqRDQkrKitNjuNngje1gFuA>
    <xme:u3ORY4qP6HmNFXt8TN6Y5d7IN18uK-VHZAnF6MMLorIsXpZdrwzVfMMbrpxps-vli
    JjMZ-h6kt-Tx2EyeyY>
X-ME-Received: <xmr:u3ORY_Nxk89nlNtRQDfZ22IVMqkWRtQ2V9j2RMdCoSmZ7ZGNYQPy71Df3TAjmH3mFuK_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthejredttd
    efjeenucfhrhhomhepffhushhthicuofgrsggvuceoughushhthiesughushhthihmrggs
    vgdrtghomheqnecuggftrfgrthhtvghrnhepgfelteegvefffeetgeefvdekjeeghfethf
    ffveeutdefjeefteevkeeltdektdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepughushhthiesughushhthihmrggsvgdrtghomh
X-ME-Proxy: <xmx:u3ORY55CD-U56c6yDu1TFVOgMRZ213q6nfwc1IySSt63SjhXZh9w3A>
    <xmx:u3ORY54VRec0aZHcCGQZY7-ZxEHnnsHtCT5ChqiwCiqe2ZLlihgfkw>
    <xmx:u3ORY5jEZPz-MygNc0xT19a-2d7zMMowvQpOcef_lC_QkHMyIr1Zzg>
    <xmx:u3ORY2i6M-MPSEAOLyCSq_HzHIpIiDVcEvg6TNjJEpOrH204PToyaQ>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 00:18:51 -0500 (EST)
Message-ID: <b9c60cd3-4c42-348e-589f-dafd7de5858a@dustymabe.com>
Date: Thu, 8 Dec 2022 00:18:50 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: iwd@lists.linux.dev
Content-Language: en-US
From: Dusty Mabe <dusty@dustymabe.com>
Subject: Any plans to implement 802.11g/n in AP mode?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I see the new 2.0 release (congrats!) came out recently (congrats). At this point
are there any plans to support more recent 802.11g/n in AP mode? It's pretty much
the only thing holding me back from switching out wpa_supplicant for IWD.

Thanks for the hard work!
Dusty
