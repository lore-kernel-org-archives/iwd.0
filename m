Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C17475
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 23:31:21 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A7E585C008C;
	Mon, 12 Dec 2022 18:31:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Dec 2022 18:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670887880; x=
	1670974280; bh=6Ve747k/UELnJO3U3IPfVu0VOJuLjFK+mwfBgHrOeDk=; b=i
	q7poHrlbP0YH0YtzSrQjG/Xjmm/jtL24pGJz8PSvjd5VCB1NOXEW5XXwF2WplsNe
	aOyTaLAE+bMxwS7Ruv24AA7uOA/pb16IpgXb3OYZxOMHCOzTTwDQ62xj4u8wtJjr
	0g8pxF3XGLxHjdDe0wwD6kZL1wUYdTetmbnns6GYYmlfaRTOMNS6pIVByZS+yE7o
	zofdY+okh7B0qj0GTs/zihawHvZXWHF9M1HF4145+K1GAaNBSO4MLRa+Poxtszhd
	yZDiKUK7hBHPNrg+QP50/8+JnkQc1PJLB/krPiA1Mrb0OEkJj+HzNhZGdH1V+/1g
	xGTHmyaJekRILh+6cVgWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1670887880; x=1670974280; bh=6
	Ve747k/UELnJO3U3IPfVu0VOJuLjFK+mwfBgHrOeDk=; b=iwWq+4QncMvh8ny0G
	UeM96bmYhanrR5vWnXO///WE2IH2AM1Mmggy1jpl1tT7kNGwHaCDixDRypTWfF3z
	CJ9xo2OHlqr/4237seN5wkvk9pP55Uj4NAFhutgI6vgmbL6CnmCoFeykH+4PU7CO
	T8qou1ssVtIv4qJKNsWXa757kt7QZkygnhJ5JHTvA/M0rf0TIf6ILf9GiFinbee/
	1pMo+u+g6AtyqBQXnFAmasUHA+IOit4o/d/l98tRWAyvhxOz0r5X3/qbqGq1er+K
	NsjgF07j2DaiQ0C8odzJ/0WGfuacfd3t31sP+AMm5HVMiG2eDfECFSBzAOI92MSG
	E4wTQ==
X-ME-Sender: <xms:yLmXY9BQLjCspvck2ZfzYwwP3ldIi7rPhC_LikmeFMkzuC7t34lRhg>
    <xme:yLmXY7hkCUjsDcC7Mu3eVSJq0TOz4Tb_DadzqbqTDKkYORAL8hKAwKPpqEBtkUrsI
    HcKs32wRjuWjNt3>
X-ME-Received: <xmr:yLmXY4mKfX3LcCZf6DkbapHkgUfssirrJQ-alB7ThmGCMjHtqV6we_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefffggjfhggtgfguffvhffksehtqhhmtddtreejnecuhfhrohhmpeeurhhunhho
    ucffrghnthgrshcuoegurghnthgrshesrghirhhpohhsthdrnhgvtheqnecuggftrfgrth
    htvghrnhepkeevgedvtdetvdfhvedvuddvtdduudffieeitdehteefhffgiedtleekheef
    tedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    grnhhtrghssegrihhrphhoshhtrdhnvght
X-ME-Proxy: <xmx:yLmXY3x-GgJXRxZ949WOArWrYuMfTbHZzqu5zpQx4L1xy4yQXe_wSw>
    <xmx:yLmXYyQHfxHu5EbB8A626CogYFI2WjDMT4WyT7jr3zRRNwQ8ohn2Fg>
    <xmx:yLmXY6b-luEpz01OIWtaNRfK01y115ad7ajXETPgzUFULVwD1qp10Q>
    <xmx:yLmXY1JdPCHAvDCcH1zjmyqJozjoJL-hE8cvj_bM56CJPJDAZy22SQ>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 18:31:20 -0500 (EST)
Date: Mon, 12 Dec 2022 18:31:20 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <0bd53fcf-7367-46de-0567-e4e0fa8cca09@gmail.com>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net> <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com> <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net> <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com> <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net> <0bd53fcf-7367-46de-0567-e4e0fa8cca09@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: Denis Kenzior <denkenz@gmail.com>,James Prestwood <prestwoj@gmail.com>,iwd@lists.linux.dev
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <1CA425C6-3698-462E-9436-5B2E860C7B07@airpost.net>




>Gotcha=2E  Having a hang in 'station wlan0 scan' makes sense since it is
>an async=20
>method=2E=20

I understand that it is an async method=2E But if it _never_ returns no ma=
tter how long I wait and this is a change from previous behavior, I think i=
t is reasonable to assume that there's a bug somewhere=2E

I am off of work for two days=2E I will be happy to continue troubleshooti=
ng this on Thursday if there is any interest=2E If not, no big deal=2E=20

Bruno
