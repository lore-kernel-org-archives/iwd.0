Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F702F2F
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 21:02:13 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2A4125C005A;
	Tue, 13 Dec 2022 16:02:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Dec 2022 16:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670965332; x=
	1671051732; bh=MKDjqNzyEnS3FTy9yUT/F9XGwBcO11cHtZA1BUo1UEw=; b=V
	Rsylmtg6U/AYfOlzc1BZ1eogWhBdIS8qPTEKH5rMmxcEyoIg2vi0nZqsAxvQvKV7
	2sSzl8DJurjkLITOWIvhUPVpg9Zux3ZYUCJoK5xcWKqe99ta+aYOK8e8Gk5nJpp/
	149OwlwPojyTimjqTuejxWcwLbgtJG5F95Rjo01IxWPytF0bBvncpMLWy/JIS0QC
	Q80GfqLbg2gcjqJmLVYRsbQGSDaVsSRAI/M9A2hSDKAzG73m7aBjEyfqJxs8aKlN
	WmR88tb0lyZwtj8x6pf/cTKgwDzbnLXbS0rfObHFaBI+O1aivXEatiE04JcLRVg8
	XqZ5UxDn6oUL5n5lj0H6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670965332; x=
	1671051732; bh=MKDjqNzyEnS3FTy9yUT/F9XGwBcO11cHtZA1BUo1UEw=; b=L
	/Eg3x6n+Unr4OooK5kZdbYqN62eXi+1YsRlxnRXNwmx7wyrfdZ5645vDaWcjAZMm
	Cz/u0S28egVzjyBSalkgoUwFHy5VXBiyJoeTSbwA0CljsmFIngTMI2hriAJalNsJ
	M11ef4nPkgtJNuxQLAmUBhl/vs5dh6TzwNumcjlKTeTiWTHCxq7wfC+xaCGo2sAM
	cybc7LoCDoQ6VhQ9oBpeWQXl9TWFR7tn3qJGrGDdjBpbmZvJcl8NX8ZIjERd9Eh5
	NEH/UmLiZaqkEzqFa6RWHHrLkZebEp4Xj4FscPtkfpD1Aq3uCu1uTL/xxl63fvpi
	t2PPqlIyGjkMfzsB2vPjw==
X-ME-Sender: <xms:U-iYY6owfph-Yo-MiOedyYg-sZvJdoEckVgjpELxTjECookPvudhlg>
    <xme:U-iYY4qQId5xGa8CHWbrVaZ7J9_WI4ntT7WR7jFon2l-9XE8yY8_lYabp_amfZPAG
    AxErbrP8x_YmPn_>
X-ME-Received: <xmr:U-iYY_Pevp7HB9aFxeEwb-LfH5V6qIhlEU3S1aS-PET_EfcAldRSeB6dsoYiOVy6wS6sfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefffggjfhggtgfguffvvefhkfesthhqmhdttderjeenucfhrhhomhepuehruhhn
    ohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejveefgfehiedtleevhfeigeevfeelteegieejueevhffgheefveetueeh
    ledvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:U-iYY56repocRN8RTsbOdLVwm1qlWaiexSMXTjawn2tKQ7uRj0fm0A>
    <xmx:U-iYY57KVnKMkgHnNfS_yINVe2fIvEQLvCkppMLJAiHCaw4SEOHzrQ>
    <xmx:U-iYY5jVjPcYm7MfDnL6fZjYjq3TwPjhYPpl6rXSkPW2xVD_CpQZSw>
    <xmx:VOiYY5FNqcycmRJKmJZtFkwkTHpeIvwleIvegDKmIi0xGlPCrTEhag>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 16:02:11 -0500 (EST)
Date: Tue, 13 Dec 2022 16:02:11 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <88c5f15eae4004d50f9862892c44156e813c4656.camel@gmail.com>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net> <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com> <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net> <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com> <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net> <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk> <615ceb63-e041-1990-81fa-568181681aa7@airpost.net> <59639a626260a24147be730f9703e0d766bd5f1b.camel@gmail.com> <8705db73-b6e8-eea4-d2fd-271d1501c52d@airpost.net> <88c5f15eae4004d50f9862892c44156e813c4656.camel@gmail.com>
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
To: James Prestwood <prestwoj@gmail.com>,=?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
CC: Denis Kenzior <denkenz@gmail.com>,"iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <BA8B1EA6-CEB0-4F11-95C3-BF3F908D0649@airpost.net>

Thank you very much for that explanation, James=2E Makes total sense=2E

I love iwd=2E Ad multos annos!

Happy hacking,
Bruno



