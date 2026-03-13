Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A823D7DC
	for <iwd@lists.linux.dev>; Fri, 13 Mar 2026 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399878; cv=none; b=nUrL2WVh9mdhU9475IdHHJHRxOJ3fkwU9kUw5+zdd4JXQROZ2M21tjL8GS4Nuib1EK/Phpf3InXrfphfjjD7qLSnLfhjf7x/AQhtujAu33+f27VC1E/ir6PZlI1rTGVODfv4s9/ZoVdR6a7gHQefUY0BhT6HHfVZZb0lkLb4k08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399878; c=relaxed/simple;
	bh=xPmALhr95JTsr5RkDhlqoM69r+FcHfg89jvAS9DMc+A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Yrg9kW4AUHati48fY4+uBoqE/fkF9+quoNI0VMuoaQOohg4Yle0/jB3udYvE343IHYUyaPEYI10OROKZeH0Ul536m2WKC065m7f6S1fBbMzfxSZqZeddDGo+BVmrugqWcVDz1wkAke6D0b0/Ni7jAKNr24vr8g2A/gFWRLiY0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d242d.dip0.t-ipconnect.de [91.61.36.45])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2B0E0CECC3;
	Fri, 13 Mar 2026 12:04:35 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] auto-t: fix two issues with testAPRoam
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20260311170210.126610-1-prestwoj@gmail.com>
Date: Fri, 13 Mar 2026 12:04:24 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E186BECA-461D-4B31-8ECC-C549AF580734@holtmann.org>
References: <20260311170210.126610-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)

Hi James,

> One of the tests expects a roam to a certain BSS, but there's an
> extra hostapd instance (use by another test) making it random which
> BSS IWD roams to. This hostapd instance has been disabled for this
> test.
> 
> The second issue was waiting for the no-roam-candidates event. The
> default wait is 10 seconds, which can sometimes take longer since
> IWD will perform a full scan after a roam scan. Increase this timeout
> to 20 seconds to guard against that.
> ---
> autotests/testAPRoam/connection_test.py | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

