Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426271CA94
	for <iwd@lists.linux.dev>; Fri,  9 Aug 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226101; cv=none; b=emd7K+abWE/Nx7qhcHgM5IFMuhe3VhTOCc5xWa0YCJITiMm09dz8D9au5hluZo6dd4QLJgMyZy4Sxi7+KnuHKbwYHDC44CjMaEWlvm3qLv1gJVuuIgp0WnS3Jci0LFfQZc/WYfnBuqEOqN1YomSBO7zg9aH/lLwk5hKGcpLsjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226101; c=relaxed/simple;
	bh=zmIDfQNVNQnpuIqBGih/A3esYguuxDirW3T+sJD8XtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUtDa4+Jgi7gteHkNJIhP8CbMwysfELDGgeSjgOU3h8qqtxqhDVyWCRt8eCEmi9UMvA4DOWK8NuarnWN3nsaEoG1sSEjKqQYGF0tiDGb9IlSrw3fNKLZTL9PW1N38ZuEpHBWZ8M2xBWSBUcyPg4mEM1lDD6VcvjSR9MmH1571Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com; spf=pass smtp.mailfrom=vonhaugwitz.com; dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b=L7lD5vSu; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b="L7lD5vSu"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WgWlD01gtz9sWC;
	Fri,  9 Aug 2024 19:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vonhaugwitz.com;
	s=MBO0001; t=1723226088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmIDfQNVNQnpuIqBGih/A3esYguuxDirW3T+sJD8XtM=;
	b=L7lD5vSugg5+8IBADmob1CDhV71rnNTPuntVCgRERkCUZx8u5pEkS5ED0oGYhrERSlPCAP
	mdUuqkgF1bev+/xt1nlIjbXuxo1W9e0WnElTSJ+9KmMovM0fKFZDpVcSEmgssui3HwRGce
	iHy7RRSrKYAPjyG67t9u4wUA/VLgr59d/SFv6JInf5gMD6z3t3VnCig87TQtAFhdfoX2gR
	/0F7t4i4R0cq5FE/fhBqI9dc3yDevd1ZBodb6WtRgwVOVPBhJlEya2GCkcv6IIuvEJmgAS
	TLx1nnzZb1cg9QsIWq+sJsPp4PjRo3ZPVML46Pyn7zUuV63AD+ItLQ8RcJBl6A==
Date: Fri, 9 Aug 2024 19:54:45 +0200
From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: Grant Erickson <gerickson@nuovations.com>, iwd@lists.linux.dev
Subject: Re: IPv6 Privacy Extension support?
Message-ID: <20240809175445.GA25@magnesium.vonhaugwitz.com>
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
 <20240304193253.GA25@magnesium.vonhaugwitz.com>
 <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
 <047c2dfc-ca69-4117-a3a6-66790b9814db@gmail.com>
 <20240804210103.GA25@magnesium.vonhaugwitz.com>
 <70e5936f-c789-4f56-a275-e1b559ea27fe@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70e5936f-c789-4f56-a275-e1b559ea27fe@gmail.com>
X-Rspamd-Queue-Id: 4WgWlD01gtz9sWC

Hi James,

On Mon, Aug 05, 2024 at 05:44:39AM -0700, James Prestwood wrote:
> I was still not sure exactly what needs to be done. If the sysctl setting is
> all thats needed, this is an easy feature, but you had said setting that
> manually still doesn't enable the privacy extensions? Is the issue maybe
> that IWD removes the wlan0 interface on startup? So setting that sysctl
> setting manually, then starting IWD, is clearing it?

I've looked a bit deeper into the source code. It looks like iwd uses
the ell library for network configuration and ell seems to hard code the
EUI-64-based Interface Identifier for the IPv6 address[ell/netconfig.c].

Best regards

Hannes

[ell/netconfig.c] https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/netconfig.c?id=4acbb92c0513644900078c348d972ef5e48fdc4c#n760
