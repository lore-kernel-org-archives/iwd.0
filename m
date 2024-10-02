Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FE1D131B
	for <iwd@lists.linux.dev>; Wed,  2 Oct 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905318; cv=none; b=kRmAhW4HzVMO/xgAa4bXRnC2VAnaOPQt80NCu9u0KwJmRb21AKXBxHfPLpXQvl5wTaTw6LFuHm9pokVmY9O2VMmMZ6Kt6S/+XgihIRDzDg1xA10mi6GgVcLCOQLtyJN6ikcVMdi4zr7d6mKALeoUGSq38blgBzXozs5Nj0hQu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905318; c=relaxed/simple;
	bh=vtS6CsOgWVgrSNwyaVGVHM3fEiGEav2V8SHQuWIhoG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PAoR8wClz8onoOdTSz+p3qgOp7SFKmmN5iutBspznAfPR+N9rB+Xf0FLmCn9y3Akjo7amVGh2HgUKGgPBLAbh0urib6zbCJhP4/zimax9jh6+K02IeELQtpejdme8G36cqFQWH7KFgM5X8phf9KnuPalgR17IdDWHGuXOfLzw/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YkM4iV/P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YkM4iV/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727905315;
	bh=vtS6CsOgWVgrSNwyaVGVHM3fEiGEav2V8SHQuWIhoG4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YkM4iV/P5RkMTtZ/d5BCVSZfG3vrInXfR3Lx+xXTqXgYzb4bxAojUF9Sn25Z2D4x2
	 U0Onhi9CmuhOPzGPq6aknOykeFZZNTJp7pixwB2xPhuLEuHIyZpYv2R9BkTQnnKArQ
	 STior+TB0Ozkda4nEaKEnsfVS6dffhMQW+PWR5OLeB7aXPoJxUMzAr72HJ6tQ1II1z
	 TcrtJ1aYMfG5pYG2gpnCG7J4BpZ8XfUrq9imDI4radJ0D/XHML/fGv1JHRV3us0J8o
	 Ij0muhDlJTJqwjH5YInmJv2ax1JpHDMudi+3/JppZmIcdLOR7Hyaoi9texzWNFWLnW
	 tr6vvV0Q6NpfA==
Received: from [IPV6:2001:4d48:ad5d:8e00::197] (unknown [IPv6:2001:4d48:ad5d:8e00::197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vivek)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E38AA17E36BE;
	Wed,  2 Oct 2024 23:41:54 +0200 (CEST)
Message-ID: <f8703c80-14fd-42b8-bf8a-d06919b0db6e@collabora.com>
Date: Wed, 2 Oct 2024 22:41:54 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
 <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
Content-Language: en-GB
From: Vivek Das Mohapatra <vivek@collabora.com>
Autocrypt: addr=vivek@collabora.com; keydata=
 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 Rdk=
Organization: Collabora
In-Reply-To: <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2024 19:14, Denis Kenzior wrote:

> IEs that allow duplication are explicitly called out:
> "Vendor Specific
> One or more Vendor Specific elements are optionally present. These 
> elements follow all other elements."
> 
> Why are the elements duplicated?  Are they the same or different?  If 
> different, which one would iwd use?

Looking at the OTA capture it looks like it's a genuine repeat, the 
contents are the same.

> How about fixing the firmware?

To be clear: We're not the people preparing the firmware. We support
a distro that uses iwd. So fixing the firmware would be great, but
we don't have any way to make that happen.


