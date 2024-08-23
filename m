Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F59186E47
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428995; cv=none; b=MRER8jZcbYm55kbmKl27CbJl46CMH513AcevIAa0Pc5xN2U/YqsVLx5EMDd80SqI909UU1nq7eYVvgBBzhmonxtqwsXwtKOFx+q2p6SR1Pq2YNWsDaOE1A9txqI8EDLK+OL5KldElJEXUw6/mxvQiMOELu9uV+hERBDfMcD8Dbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428995; c=relaxed/simple;
	bh=/EkYMvLQluBsB9p+i16WJJV7wLPnmiqOPs4qiXxnl4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxmqOrttQC18Y/BRIkDq8FR53eH8H9PAr2EBtTprtHUcDpoxuhYK4GThZ1KIPMh096+6FXUNhABkieqZOqnRg7ggCPU6Qzvn5Z3EmkDtoDJAi+muNS7n1haEmaMoGuoAXNNAeRhcbQE/fL4Xiv0mS2hliOfAsVDjLpwIlHyvJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDG1/Lur; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDG1/Lur"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70943713472so1548522a34.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724428992; x=1725033792; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PH3v9MjymzzZ4L+se6pTRASDpNZ2VBoBzDsbi/IuJNE=;
        b=eDG1/LurGXWVryMshM0gJGH24NFKRg+i246cFPVDv+ZB/bCKe5DHf0txX0cnWf8RG2
         qlNL+HrSupnfJt/EG0x/zF6WwficpR5Rtli4PEcloNdFe7YNn6A5xCZl7ny10HLx2g3z
         URjqlELcFi60eoKMVg5lP4bHbW4O4oDgE41BlBixOFfurLrinxxuaKMv9t4fbKnBEXHs
         MZHf4LKiQXRYRYzoobpVseoQsOKspg+LWZYrjzdRmoe6xj8TBT3TZ478OsQ6Qiqw8ouL
         vL15DAx+hkjgK+YF/zXYA5ixztk+Fdd4a3IMUBmnukl3CtD2XUlZaoOz07xJ6fKqv3jt
         +htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428992; x=1725033792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH3v9MjymzzZ4L+se6pTRASDpNZ2VBoBzDsbi/IuJNE=;
        b=W26jKycxiZZhOt1KX18WlRuuh6CuAt2U+kSMxpS65xqgi97Rtv/Ci4mKZ/r4QEQYer
         KVN9FWdePnY360Lquisq/JlMj6E0wzeh8VHZwQIiwc2YPFvKoT34W4feh2+TLFQzk6sq
         i/vazNXzfim5HJMzbpWaEDowtiASY8xbbNC/rYCEkFJIslbq5Zv9Lgf4z7eAsI87oElg
         5C8XyjaPI6PoR6xY+YCzVyC4LvOKsSuU8s6c9jG93gIBrXA74oaAOyeBdP3KIP4DQFgm
         jJwa9LHbBzvvz4jUzwlb4i+wb6bA3Z7jyZKI4ujft6zYExMGKefRqsyDh9eRJunrNnI6
         vt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHyLfWxeAfHuZKQvWmxQJfPHMJnH7W+RBWpH7YYCEWjq1+lm5Wde2ledZLqPmQDwcjoGg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwcAi60vYLFJQ1FZkKro7wSUTamHd3dbS+kJXgTgbyGQzBAhwKG
	VCoDbeEELHM8meVVIvvKXXFTxHygsYgnYk6HnHMdtnLQ1JNYumUW
X-Google-Smtp-Source: AGHT+IEyiVk7/Dwgnmg2zLoM0+13eHsSTvyx6bZ9ZVOFlf4iEY8ugLbUrDZDcbCGuD/8MCKTGvWEbw==
X-Received: by 2002:a05:6808:6489:b0:3d6:331d:b511 with SMTP id 5614622812f47-3de2a8a634amr2694169b6e.32.1724428992432;
        Fri, 23 Aug 2024 09:03:12 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3de225c95c3sm742655b6e.46.2024.08.23.09.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:03:12 -0700 (PDT)
Message-ID: <1ae5fbdc-631b-4bac-a913-2011a7e9996e@gmail.com>
Date: Fri, 23 Aug 2024 11:03:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] doc: Document station Affinities property
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240819175151.1310546-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240819175151.1310546-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/19/24 12:51 PM, James Prestwood wrote:
> This documents new DBus property that expose a bit more control to
> how IWD roams.
> 
> Setting the affinity on the connected BSS effectively "locks" IWD to
> that BSS (except at critical RSSI levels, explained below). This can
> be useful for clients that have access to more information about the
> environment than IWD. For example, if a client is stationary there
> is likely no point in trying to roam until it has moved elsewhere.
> 
> A new main.conf option would also be added:
> 
> [General].CriticalRoamThreshold
> 
> This would be the new roam threshold set if the currently connected
> BSS is in the Affinities list. If the RSSI continues to drop below
> this level IWD will still attempt to roam.
> ---
>   doc/station-api.txt | 17 +++++++++++++++++
>   src/iwd.config.rst  | 16 ++++++++++++++++
>   2 files changed, 33 insertions(+)

Couple of questions:

> +			Setting the affinity will lower the roaming threshold,
> +			effectively locking IWD to the current BSS unless the
> +			RSSI drops below the critical threshold set by
> +			[General].CriticalRoamThreshold{_5GHz} at which point

Should '{_5GHz}' be without the '_'?

<snip>

> +
> +   * - CriticalRoamThreshold5G

What about 6G?

> +     - Value: rssi dBm value, from -100 to 1, default: **-82**
> +
> +       This has the same effect as ``CriticalRoamThreshold``, but for the 5GHz
> +       band.
> +
>      * - RoamRetryInterval
>        - Value: unsigned int value in seconds (default: **60**)
>   

Regards,
-Denis
