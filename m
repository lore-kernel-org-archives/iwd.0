Received: from mail-108-mta110.mxroute.com (mail-108-mta110.mxroute.com [136.175.108.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE181C30
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 16:35:55 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta110.mxroute.com (ZoneMTA) with ESMTPSA id 1819166c57f00028a7.002
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 23 Jun 2022 16:30:40 +0000
X-Zone-Loop: 2eb8b851f5b0a81b61c479f4048595a1bea7877ee543
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=In-Reply-To:References:To:From:Subject:Cc:Message-Id:
	Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ORp9IkLth8jcrKNjzfEkqvQnlmm9ZlOngTRpRdZzirI=; b=StKMVgbrzsyFvf9YKUixRZWWue
	SlUkqoCqrDVJiGM/kP8CZoTf8q2wBNgP2hVfmMvlpVb8/op88d0DBKFkv85WG1fkvmvAb6Xfl+XpO
	X8jXl9DMxyi1tUeY1jWthNHvlgL5rVd+c4rUz+XP9LAbgd8VLcU8uDBXfMyEnKtIlhuVtGL5Ai7Cx
	f8rFbjvCLgFYsq82MnqZcnLPJeZ47KYjjk5v+z7DU9qSCsOhfqWDWp6cqILYU357dFDquM2y+65cr
	GHBJf59bi2NLF+5tBDcxxfbwe/LypIy3GCmeLWPJ0jZe6TlfEJTNvOQYg5IDmnQLeuNlfpQirc3XV
	LhwVmA2A==;
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jun 2022 12:30:37 -0400
Message-Id: <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
Cc: 
Subject: Re: [PATCH 2/2] doc: Add State and Role properties to DPP API
From: "Jesse Lentz" <jesse@twosheds.org>
To: "James Prestwood" <prestwoj@gmail.com>, <iwd@lists.linux.dev>
References: <20220622194142.213135-1-jesse@twosheds.org>
 <20220622194142.213135-2-jesse@twosheds.org>
 <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
In-Reply-To: <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
X-AuthUser: jesse@twosheds.org

Hi James,

Thanks for your feedback.

> > +Properties=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string State [readonly, option=
al]
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Reflec=
ts the DPP state. Possible values are
> > "presence",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"authe=
nticating", and "configuring".
>
> I think a "stopped" state would also be needed.

As a user of the API, I can infer that DPP is inactive if "State" is
undefined. A non-optional State property with an explicit "inactive"
value should provide equivalent information; would you prefer the latter
approach?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0string Role [readonly, optional]
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Reflec=
ts the DPP role. Possible values are
> > "enrollee"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and "c=
onfigurator"
>
> I don't think you actually need this one. The role should be implied by
> however you started DPP:
>
> StartEnrollee() -> enrollee
> StartConfigurator() -> configurator
> ConfigureEnrollee() -> configurator

One use case that I'm trying to address is when a user launches the
front-end app while DPP is already active. There are two ways that I can
think of to handle this:

1) The front-end stops and re-starts DPP if the user requests it. This
only requires iwd to provide State, so that the front-end can see if a
previous invocation must be stopped.

2) iwd provides sufficient information via properties to restore the
previous invocation: State, Role, and URI.

I originally had option 2 in mind, but if DPP invocations are intended
to be transient, then perhaps option 1 would be more appropriate. Let me
know what your thoughts are, and I'll send a revised patch.

Thanks.

Sincerely,
Jesse
