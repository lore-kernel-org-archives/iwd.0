Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A14376
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 02:50:04 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BF9343200906
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 22:50:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 May 2023 22:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikesilva.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:sender:subject:subject:to:to; s=fm3; t=1683600603; x=
	1683687003; bh=9sDsEyynY0FuvwEIyeaolyAUpnawMDI7BzAqUwtpVoE=; b=k
	g0A9dZ4DfWau/SfLRqWLxtOjQ/L58bpp1m821WGdRtyjNcByHiyruH7qKlt5w6wB
	Y7/nyaDDA0h6YMU5XHWoD0CODpflcSNDjJ3e2Dc2JxJRVWU1dDhgrm+9B+b/IwpE
	mX62MqseOfZwHirClytlhwYqAXwBuisdFpPPthF5SFe7UMuGP2pVXXIzNiAkq98S
	P1Dqllt0lFq76IofQ5drwptw3autUgYUWGvLx8fJeJYrle4+MG3HNTarUPSmL+oJ
	G+h0H6tbNbThXOQOCKn2FIdrTIY149ghq6cqxaewYO1ALikYmemp/vcY+moiuDpB
	cDgwnJ2E6T77B1AGTgAJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1683600603; x=1683687003; bh=9sDsEyynY0Fuv
	wEIyeaolyAUpnawMDI7BzAqUwtpVoE=; b=e3hrz6Tz6fhGoAA9B4hc7drRY7dTp
	ezl/WEFuoe+tI1M3AcPzOqqXB1Z64OHm4E6tcIv8wqRfGFiPwibWnxQ1zTCo/NVz
	ETtGeoFuVMnOLTrZRH5TUWM/r8iXNiHrSMX5YkiqPIFJpBDLakkYggktJlzIVROd
	Z1W8Y4M6QscLHBsNWBVokTrVUJUQ7LNU1iHP/S3XFXqFFeQpEvYAtVpvyhBYH1pN
	C4/KApEddYgh6xz91Rh5dJXcbu/uuTi2T2k2rSmrCGBzNRcVQ1zp3Xcr1OEJY0xQ
	E8whGH+fzjmU4Peh1g9hb7sgpsZGHLMM8vH3ykNa6ky9CcW0HygHvEhvQ==
X-ME-Sender: <xms:27RZZDSiXyHh3umsPU3PwwJe3Yu0wexF0sMk878gcYr5ykFc37tO4Q>
    <xme:27RZZEzkWAmaxKS13moL0vuLvvCIxkLogmrP3ls-ghl7BJWDxW-aF2uHDVCglITdz
    F5nUYtzTjivRG3-Mdo>
X-ME-Received: <xmr:27RZZI3UZS37pJrm_DMhU6KCTZQe_mAmhPbiS6qYtImtBD4EqXpfQJKxtCg6O366biPJHktUDL3tgnIDFfCVMGgMZiaIA37GflFjBeBGLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefledgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
    hhtdejnecuhfhrohhmpefoihhkvgcuufhilhhvrgcuoehmihhkvgdrshhilhhvrgesmhhi
    khgvshhilhhvrgdrtghomheqnecuggftrfgrthhtvghrnhephfehteekteejgeduledvje
    eijefhtedtheeukeehveekkeefieelfeekudfgkeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhhikhgvrdhsihhlvhgrsehmihhkvghsih
    hlvhgrrdgtohhm
X-ME-Proxy: <xmx:27RZZDCaMU7YuzserZp9VmNx5GKfIjWYLwIzS4z494mlby4aXuiL_w>
    <xmx:27RZZMiKKdyXWPKTp73x0a-y4PLG0zavTrok89yuplJy6xD_5v6O4g>
    <xmx:27RZZHpjpvETBL_RMzGgbZOet8G4wxjx8_6yQi8FYDRQ1NCdrvqovQ>
    <xmx:27RZZKfUAA1_-ETrRcjWBdmzjrUUr5veQBz8i6KGV35_rV4FEUo5sw>
Feedback-ID: i3a5446d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <iwd@lists.linux.dev>; Mon, 8 May 2023 22:50:02 -0400 (EDT)
From: Mike Silva <mike.silva@mikesilva.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: powersave support
Message-Id: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
Date: Mon, 8 May 2023 19:50:01 -0700
To: iwd@lists.linux.dev
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Does IWD support disabling/enabling WiFi powersave/power management?

Perhaps, I=E2=80=99m failing in finding it in the documentation. It=E2=80=99=
s possible to do this as needed with ifconfig, iwconfig, or =
NetworkManager, or to permanently configure them to enable or disable it =
at boot..=20

If IWD doesn=E2=80=99t support this, it would be nice enhancement if IWD =
could when managing the adapter/connection, as some drivers do a poor =
job of handling powersave being on.

Thanks!=
