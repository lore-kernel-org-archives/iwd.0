Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9953B8
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="d3JUXFQ9"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1701828989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ccUtTqz2lihZK+C6JuJQfV20kneNkvP3prWGuENL/4=;
	b=d3JUXFQ9TmILI+G50se8x11GwlW2LC0ajmB9vo9fiAuiiiLd+pvR2eVJTZs6rMLUQZTK0V
	gQE8wzyIQJzd9v1KAD/PwakvNk/Sw+xsIir/pCPEXmi5DYc2k2W2uDL89rnGH7C03jKPAA
	WdUorexlnI/d7GptV00N5LPtWq3omgY=
Date: Wed, 06 Dec 2023 02:16:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <9393bad9fd0f9aca758e65a0a998d39787277498@rjp.ie>
TLS-Required: No
Subject: Re: SAE password identifiers?
To: "James Prestwood" <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
In-Reply-To: <a61d267d-774a-430e-adc6-5fb1f5075860@gmail.com>
References: <a61d267d-774a-430e-adc6-5fb1f5075860@gmail.com>
 <e3bb952a9c0550a945f002b1dc5c596e370d600d@rjp.ie>
 <38a83f9c-6ac6-4862-99b1-128d811a63e5@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hey James,

December 5, 2023 at 8:48 AM, "James Prestwood" <prestwoj@gmail.com> wrote=
:

> I went ahead and added password identifier support (patches on the list=
).

Wow, that was quick! Awesome, thanks!

> I've tested this with hostapd directly but if you have an actual produc=
tion device that supports password identifiers it would be nice to valida=
te this actually works.

Unfortunately just my usual router with openwrt. I don't even think the l=
uci interface supports it atm, but the hostapd version used certainly doe=
s.

Cheers,
Ronan
