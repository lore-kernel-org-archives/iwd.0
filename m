Received: from mail-108-mta135.mxroute.com (mail-108-mta135.mxroute.com [136.175.108.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5741FB2
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 17:30:10 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta135.mxroute.com (ZoneMTA) with ESMTPSA id 1819198823a00028a7.002
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 23 Jun 2022 17:25:00 +0000
X-Zone-Loop: fb167b4756edefa74eb81b36a0e525c71b040ac99952
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=In-Reply-To:References:To:From:Subject:Cc:Message-Id:
	Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N+r2pEGhueUPhOCwMXT1rFSV+FMobmFGUdw0SvsmEMc=; b=jvkvzwYV8g4j4/P2edgc/0XB/4
	u3tJI67tqRl0XrgO5NJmaxuL46xS/HPof5u03vNBEq9Ky0hdZx1KxSmdX0gRCnq/lZDqhNji9vxKy
	nMQ29SAtZbC1bEaur8weYAMIUtV8dxL9f1QU843IqV3gKFvUkN1Dw4iRQY/TNm/W0eBw8UETFKyw+
	2YN87es3WkPO7iU4DU+aHtA5NoGVVPMSBFAfi1P6m2fKSnbG8XPlLL/0FAQvxgWHS2tg+Mrx0fauK
	c5u7P3mWfCItbaerFaDi5HmQ5tpLj9cliuYrRAPkjFXoxh61aTYdGc8tjQoaXGuwHT4VoOvKfdfmA
	j7VjYSmA==;
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jun 2022 13:24:54 -0400
Message-Id: <CKXOTA3EHZFN.2QPFAUYAGL28G@laptop>
Cc: 
Subject: Re: [PATCH 2/2] doc: Add State and Role properties to DPP API
From: "Jesse Lentz" <jesse@twosheds.org>
To: "James Prestwood" <prestwoj@gmail.com>, <iwd@lists.linux.dev>
References: <20220622194142.213135-1-jesse@twosheds.org>
 <20220622194142.213135-2-jesse@twosheds.org>
 <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
 <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
 <b7ea87b9c85a5bd6c4d6d21548d6db3ebd2f6274.camel@gmail.com>
In-Reply-To: <b7ea87b9c85a5bd6c4d6d21548d6db3ebd2f6274.camel@gmail.com>
X-AuthUser: jesse@twosheds.org

James,

> Yeah, I think having an explicit value is best. I think it makes it
> easier to handle for the consumer of the API.

Sounds good.

> > 1) The front-end stops and re-starts DPP if the user requests it.
> > This
> > only requires iwd to provide State, so that the front-end can see if
> > a
> > previous invocation must be stopped.
> >=20
> > 2) iwd provides sufficient information via properties to restore the
> > previous invocation: State, Role, and URI.
> >=20
> > I originally had option 2 in mind, but if DPP invocations are
> > intended
> > to be transient, then perhaps option 1 would be more appropriate. Let
> > me
> > know what your thoughts are, and I'll send a revised patch.
>
> Out of curiosity do you need these properties purely for displaying to
> the user? If so I wonder if they shoud go on a new interface, e.g.
> DeviceProvisioningDiagnostics.
>
> We have a similar concept with AccessPointDiagnostics and
> StationDiagnostics. These interfaces hold extra information that isn't
> really needed to use IWD generally, but more debugging or displaying
> information in a UI. These seem to fit more into that category than
> needed for DPP in general.

The uses that I have in mind are:
1) Notify the user when a device is being configured (by monitoring
   State)
2) Determine whether to show the user a "Start" button or a "Stop"
   button.
3) Display a QR code and a label showing the user whether credentials
   are being given or received.

The benefit of properties over method return values for (2) and (3) is
that the front-end app gets to be stateless, so that the user could quit
and re-start the app and still see the QR code.

Thanks, and let me know what your thoughts are.

Sincerely,
Jesse
