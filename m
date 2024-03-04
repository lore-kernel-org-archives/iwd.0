Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244C78B65
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580782; cv=none; b=YBGo9Qy/fH6+dd+xwGfmQG+rxCjh3szUAcaoxv/dgM7lERAT6GBREVO5CruV0/sh/2eJdabs8BRD2Bk6l4ymSs8gZ3occMG8h0oBU5RU/C2jkqH3RAnt0/SY0layjQ1dQ5M0MKlOO5vlyP6qrwk0b/EyHjI9VCi0LNia3gD1SOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580782; c=relaxed/simple;
	bh=MDRfZO00+S6n+PKbVBDGpOJPrsQE9IudDuhzplOCFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1f+iCjc3RlZTMGoSRCszeaUBnyS/bpZeWbWG+dnwnMgTC2aaOb5c5T1ateWR6tFnZqg5hP/uF8nQLJohu+1d1d40/CNSyKV/jujGPfZeGXSE9avFsTT93EalDrbp/+SvnII5KaE4ZdNT6QVeovGkrpHQQtzMZWYD3iHvLPnQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com; spf=pass smtp.mailfrom=vonhaugwitz.com; dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b=kqq9bA9L; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b="kqq9bA9L"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TpTPN0W3kz9t3t;
	Mon,  4 Mar 2024 20:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vonhaugwitz.com;
	s=MBO0001; t=1709580776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Yd805m4wSL9eC+WLaXG0AZX9yy95I/9Ivrygq6znM=;
	b=kqq9bA9LaAaYZR3Ds00t55iq3nL5ZFTzobUgnW7s10Lq6oT6HST0Qgy8taTG88zzpvMuaD
	eUJu2LCMgQAFMZat9q9G60MjQROYDpGVxQDvOE72C+EDx9vGKLkHM1cqCyUnQOO/83AEvX
	ykcLk3D6fvnuNkBdzMLYIp9DXjQp/ODi+5dwSRZnrS6MkM3ThZypu1vFiDjd/kVPjDqN3P
	Dh4fZKsMisNVXYDB2ik7aRhd5FNcv3JPkYFriJBshDV0P6rYKZgyBeI6GOv+DALjf6gS8p
	9AROtjq1qprNPaCMX5LETSqMiAAi1Htki+tEj1TUbXH9sCYKFO7xa00r0ezTLA==
Date: Mon, 4 Mar 2024 20:32:53 +0100
From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: IPv6 Privacy Extension support?
Message-ID: <20240304193253.GA25@magnesium.vonhaugwitz.com>
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>

Hi,

On Mon, Mar 04, 2024 at 04:30:27AM -0800, James Prestwood wrote:
> I'm not familiar with the privacy extensions specifically, but you can
> enable MAC address randomization which should hide the MAC for you. You can
> check the man pages for more details but in main.conf something like:
> 
> [Settings]
> AddressRandomization=network

MAC address randomization hides the physical MAC address but does not
prevent device tracking (within the same network). With privacy extension
enabled, the IPv6 address is randomly regenerated every few hours.

For more details see [RFC_4941].

Best regards

Hannes

[RFC_4941] https://www.rfc-editor.org/rfc/rfc4941
