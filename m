Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F118593A
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429250; cv=none; b=YSUY5eoVM3n4+p33NbMolONjzYPeOqKlLU8v/8FG3OMxjKQoQzRWb38IGi1hHilXscXHZerKirBmNXtxE/m62lxoSOA2rU1nQSPs3gwt1Qia3RjpOXlht1XtZiAyi+ziqOAFr0lufKAa0Iypg3/KtdkI+rPt7+2b+HPKZjcybSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429250; c=relaxed/simple;
	bh=UkvcUWlLr9yPpAv6R8LWcmv2IW81L3jPCKMgOeGZt6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rzciYBDeyAnPmzYen9dzK/26S4RNiX5T3SqECV+51XzhKnNj0iOpPnTCnOay7hHEMpH0C3ZMAMtn/D/GXoGbhwvjqjnFVMgcGYxNAlJfRKF9efelWHQcf1nwC56yJxsjgx6vSjprUqkgCwZTbjadok4TZ291hP025SDbeTouZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meGjT3s0; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meGjT3s0"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70968db52d0so2241637a34.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429248; x=1725034048; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXRfUABbxMbMuV0fUCYWW4QaNO6i2bUTErnpV3oCWK0=;
        b=meGjT3s0+Ksu8ZjYk3KR5JLgI6Gpa1tMYcp5BA+m86/sQdbL6wTwtLG3zY3Z8PRaPg
         uKf4TeRXWtDkgSqTiD4boLiqgfewEzg3Fl5h4XuYYsL5DUAuwqwHw+CAoylVyYganiiX
         PqTafBFECctWJlVlQO6u0uFREJw3OF1t1ZKwH+RwkEDMZDwqbdj8mQH5yav18gWpEaN+
         4XP/gdRs0c8OEHeQBzEJxgcOdsbp9MlxU21e3rDEimaO4BuIUYnJ5PBFHwWEmMnYQ+Gp
         hFbIi00nU2fHbqYI4MDRorDLs3z0abEI12Z1VY1w5ATthe0tJvEOJnnaz7CH1J4qsZxz
         R0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429248; x=1725034048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXRfUABbxMbMuV0fUCYWW4QaNO6i2bUTErnpV3oCWK0=;
        b=h75/SAoAZC32QT+9vWPbVwqFVqGm5NwN2uyMoRDaOjYRTk5nwiF+l4CjroHrXhS3D/
         kmstfp/FQEeDh9MVuTh1afufxKug6aHL/MXLFS6zpWoNJ1CSOkcCD2E/kk47f7h4DJEW
         l9cSQUDONkE/C0bI2GEKgtPVqbb9Hg0J5PhDejf+nSpdiS4AdDdPYo8L6OEIQ90mhh7u
         GxQXXDl7YbsQDEUzE47iAp2euvuqlGw4LjOO4bW5zNMJICj8tX8PByVHQrytVwgrIrDX
         B9yTmyXpjhdLv5QzsD7AmlK9k/5d4crpyvYpqwHvDgc3HgIlr2qZgwgJSJY98mt2Oc3i
         Df/w==
X-Forwarded-Encrypted: i=1; AJvYcCV7EInZxpIh31lpPHh9TCFI7cCExB/fNwbWPPSHvWYbzT8bnHO8xmjvJU9XDVIYTIQnC9E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhu0U5xqPEohXI4D9rDAHDIWebQGx5yZ2jzk+vmPqWTr6AiWQR
	bnfVM/E1zSVg5Lwvjx//67VuxMW2fiH1Ehu1gbSV5McRiqFlb1q2CPpITw==
X-Google-Smtp-Source: AGHT+IFm3kpVfcrW0dvGjitjtpHPu+1sAkO0Dwc1oM+7viqXPwwNf1DesGOCkMXQtbo4KXDsDIvgMw==
X-Received: by 2002:a05:6830:2705:b0:708:5f27:ce89 with SMTP id 46e09a7af769-70e0eb1e442mr2961145a34.14.1724429247762;
        Fri, 23 Aug 2024 09:07:27 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03abe7b6sm710375a34.41.2024.08.23.09.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:07:27 -0700 (PDT)
Message-ID: <1582d6d0-a5c5-4c72-a170-f49b53b213e4@gmail.com>
Date: Fri, 23 Aug 2024 11:07:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] netdev: add critical signal threshold level
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240819175151.1310546-1-prestwoj@gmail.com>
 <20240819175151.1310546-3-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240819175151.1310546-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/19/24 12:51 PM, James Prestwood wrote:
> This adds a secondary set of signal thresholds. The purpose of these
> are to provide more flexibility in how IWD roams. The critical
> threshold is intended to be temporary and is automatically reset
> upon any connection changes: disconnects, roams, or new connections.
> ---
>   src/netdev.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.h |  2 ++
>   2 files changed, 53 insertions(+)
> 

<snip>

> @@ -6278,6 +6321,14 @@ static int netdev_init(void)
>   					&LOW_SIGNAL_THRESHOLD_5GHZ))
>   		LOW_SIGNAL_THRESHOLD_5GHZ = -76;
>   
> +	if (!l_settings_get_int(settings, "General", "CriticalRoamThreshold",

Can we move the strings to a #define somewhere, similar to how knownnetworks.h 
does this?  Easier to review and make sure the setting matches the docs.

> +					&CRITICAL_SIGNAL_THRESHOLD))
> +		CRITICAL_SIGNAL_THRESHOLD = -80;
> +
> +	if (!l_settings_get_int(settings, "General", "CriticalRoamThreshold5G",
> +					&CRITICAL_SIGNAL_THRESHOLD_5GHZ))
> +		CRITICAL_SIGNAL_THRESHOLD_5GHZ = -82;
> +
>   	rand_addr_str = l_settings_get_value(settings, "General",
>   						"AddressRandomization");

Regards,
-Denis

