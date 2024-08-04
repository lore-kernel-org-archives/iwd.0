Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1701AD59
	for <iwd@lists.linux.dev>; Sun,  4 Aug 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722805281; cv=none; b=PXybKA2+Pu+qFdnRp49CMiikq9ddWIgiTsyTbYCJAh212YJfRHdlDjz23gr/Y8NIB+68VloeXEke0IaHU4matDw7cZRAqrBmoJbwxMhNVKZQICTEkdr1MVtTPsIo9XgzhW57SOFEXshnyr0Elq30x6cfG3t9IMscS7hGkepyp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722805281; c=relaxed/simple;
	bh=Qairf18vKmvDrPYdGYajIEiHn77Qi0T/9ScGJkr4P6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prfVhrZUuRlXB4Wao4Wc68ZHXuUDCzPTSVtQiN0NzrSVpSse6UV3mf3IMyNYPd6TqpxoApbkHmHv2iZ/3GAU7fIBQTjMitZJ3rUDFAZWVKP1RRcB4umIBpA2JBpV+VVcJAkX89doEMBMwmdjgfDqx0TgMAOBPqjgZWLfpMTDpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com; spf=pass smtp.mailfrom=vonhaugwitz.com; dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b=IK3mNEmn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b="IK3mNEmn"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WcX6V1V8wz9slg;
	Sun,  4 Aug 2024 23:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vonhaugwitz.com;
	s=MBO0001; t=1722805266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUhBzSvPnVMlzCRJCKRGj5O9E1ul4XLs+kCn4RmSZ/M=;
	b=IK3mNEmnBgpBjXEPx3qcP/SwbrgHE11a9l72ws0tLLv4VUZJEz1TN9G/bTQLQqECR3g+T7
	KNB/7Jp6Nw/HVt9F+aWUMIx4G/SWU1ohg+3aaF0qPHAWj13QPfsCcCFexo6sZ3j35iEYLH
	m8osxd3rXCWZXh7aUZDpiB0C4Tg5B+Ptbz4mgXEY0D1VkDAvuUfwR77HlyB6IQbYm9KUqp
	Qh01xkCIQ9qM1fV7JPOS7rqPM4DtEHc7eL9VGzx/+7aFAE+bhDnqt0URA8+7O3V+/jSl5N
	W7RDi7TsQb2dUXt/uKyAC3121wpp4xDBpMsBbHj7LnADjihibVSiXXNB7yL0HQ==
Date: Sun, 4 Aug 2024 23:01:03 +0200
From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: Grant Erickson <gerickson@nuovations.com>, iwd@lists.linux.dev
Subject: Re: IPv6 Privacy Extension support?
Message-ID: <20240804210103.GA25@magnesium.vonhaugwitz.com>
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
 <20240304193253.GA25@magnesium.vonhaugwitz.com>
 <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
 <047c2dfc-ca69-4117-a3a6-66790b9814db@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <047c2dfc-ca69-4117-a3a6-66790b9814db@gmail.com>
X-Rspamd-Queue-Id: 4WcX6V1V8wz9slg

On Wed, Mar 06, 2024 at 04:19:41AM -0800, James Prestwood wrote:
> On 3/4/24 1:40 PM, Grant Erickson wrote:
> > On Mar 4, 2024, at 11:32 AM, Hannes von Haugwitz <hannes@vonhaugwitz.com> wrote:
> > > On Mon, Mar 04, 2024 at 04:30:27AM -0800, James Prestwood wrote:
> > > > I'm not familiar with the privacy extensions specifically, but you can
> > > > enable MAC address randomization which should hide the MAC for you. You can
> > > > check the man pages for more details but in main.conf something like:
> > > >
> > > > [Settings]
> > > > AddressRandomization=network
> > > MAC address randomization hides the physical MAC address but does not
> > > prevent device tracking (within the same network). With privacy extension
> > > enabled, the IPv6 address is randomly regenerated every few hours.
> > >
> > > For more details see [RFC_4941].
> > >
> > > Best regards
> > >
> > > Hannes
> > James:
> >
> > I believe it’s handled in connman with these APIs:
> >
> >      https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/ipconfig.c#n528
> >
> > with the Linux kernel “use_tempaddr” sysctl setting. I assume iwd would have to replicate this infrastructure, or pull it into ELL and share it that way.
>
> Hmm, if this is all that's required then shouldn't this already work if
> Hannes is setting "use_tempaddr" externally to IWD? Of course having this
> within an IWD profile setting would be nice, but I think there must be more
> too it than this right?

Is there any news about this feature request?

Best regards

Hannes
