Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3F3BD64D
	for <iwd@lists.linux.dev>; Mon, 23 Mar 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278897; cv=none; b=VxDitKb7smGts80mdMJu6eRbB3zRVHhBf4DHcOF5+jsCMDyZ5mB5FMp9BTldgL0ljNH0N8u61F+czW8l1l+R4+d+Ja1GDaK9J4nzS5q6TDYCZzdI9SVDMJCAG0O2CEbFIE/hVqdLvhNWD1Q5oRYXHld7I8jpyewA1bw+/Hi9VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278897; c=relaxed/simple;
	bh=yWnsx8hXQnRTkrNb4cQV0e/7bAmmE+kZX6ygulGD+lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B7BWMKwnVfIOkydle4N0Z1A1Y8AoEXuZz7BQp9jbevrbG3DqfMcQLorzxLHq0iQtHF2ykkXz/J694VZXqrCxICO/I6E5xNs6zCYgJ0chwaiAw+9NzgVebfk7YXjK7z1SgY2xUOxVBc5mrb9sqHVbM5U6zhpDOwnDPKlx5DXGPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP9dw0Dk; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP9dw0Dk"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-41c4d660b19so342515fac.1
        for <iwd@lists.linux.dev>; Mon, 23 Mar 2026 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774278894; x=1774883694; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0R4IA72Gcsjpq9U8mzB7vt8Ju94Fk+6NavZqMtQKENw=;
        b=lP9dw0DkWQRYVEHgaLEMe52U0PVH3gEZUaafT9aAxkCuXJftyzmU08ppHO1p3VPgAz
         qldLsoxjcCk+hK5N9mSxvChcWrz6xilqbg+ezO8KW8FkdO8xHQ1GE1GpMUrwmbjTP/zO
         SMz6ASH5IXRZDApBcHaoJhS14dcGS0PDWyuqA4r83JHtCq7MeeqLViFZHd6bHkoLh63i
         /d1qEXwZY3WrW941gvwW2kDENQIaj+wmNj27wohcqAbtIZbbzTMihsr+OBUg8MqVvFpO
         JaArpx1c4HC8y6qq/194n7FwpyrHWKYtBS6Zhb6mbPvyHbqaHOII/exZLRzJNXv+DGeH
         roGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774278894; x=1774883694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R4IA72Gcsjpq9U8mzB7vt8Ju94Fk+6NavZqMtQKENw=;
        b=G08fjOdmIqEl90xFH07YBtxntO9C8ennpul2zR+ifHmPdVEpT+y4UoAU98w1gCcLC+
         U6CbZpK0fcTW9BsX01SDtCSsW3hIq188mV+xnrpRdrWPTN6pvfY5YsfqI2XcVRP+NvQR
         6OTpQSZ9SSnQQhf+2EvDO+pSAfSRNExJaaRQ/URf0MrCzmgpXPoJuNCs/xBtSczKzLo5
         2vP3lyBxVzuRRPrMsQeATgNzeIZ62XZRuxFh+Gc6YTKRy8JdJmupfMVpyAFJGvNxUGEk
         HPKCIZyQpXd/GvkiUkmhlwEt8XeGzTINY/G1UgrimyVXjDG5jv3CeFOiIwjXOp5cplJJ
         iSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKYJb100hviL0iMBufCqfrfzUE53DQr0d/XpJvqR/mcP+CvrwGg8UPdWUpT7f2WPdQdCE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpLmRyqWQiZQzwoYQp+kcKHl61S/jONnMV3o5P2NhNtDrpa+Zx
	5H8uMqW5ebsUg6nqB7tdFwed2zOwBdU1oU696qy89KQqbsQZFsCV60zZ8qeClg==
X-Gm-Gg: ATEYQzxUCFHWJ3rF8esxKWStr/ssNQatDikmuhb9nvOM88HSgke7O3U4+IXbDaVXCCD
	sLslXmA6Zb/10STMtug12OGQ0iMOYVvvU1fk6MMujP7CXBrNrVPaggPHWQXeetpM1VPVl4PSmTQ
	dOYVsGIJb7NzPEKeYAApHmbGnOP/l7iAxcLUZ9+o292FESCZ0MNblwkUAxjCdurvjiQKdsvOPUQ
	qh6QUXMGxQG6LlH49oSr+JVYMv2Yjydtvh+Yh5OgSsp/D8Z0EIqD6/LQ+xTODUIhn3PpudVdW2o
	MKVo7GsFZcz6COrWTuWAa58p8mQ0XZblCDXyaV3VGDAMDkj3e8ueDNDbn/OFQJpb00iph0vL+cV
	6lO+2kHytydX6IBKRnjevqublFvOgD6iH4+iXUxAbyGUNbcXucFvOvVpbuvZ8g3JjgfC8ZvbMDZ
	limMC1VstTvVohcdOmelz3p9IqH0gt1m7nrR68so6yca4=
X-Received: by 2002:a05:6870:cb85:b0:41c:3225:f98b with SMTP id 586e51a60fabf-41c32268758mr4729084fac.10.1774278893560;
        Mon, 23 Mar 2026 08:14:53 -0700 (PDT)
Received: from [172.16.49.134] ([70.112.199.191])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41c14ddbca8sm10851122fac.15.2026.03.23.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:14:53 -0700 (PDT)
Message-ID: <4b8f1537-70d0-4b19-a861-12fd23f1d75f@gmail.com>
Date: Mon, 23 Mar 2026 10:14:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] pmksa: add pmksa_cache_flush_ssid
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20260319180525.136095-1-prestwoj@gmail.com>
 <20260319180525.136095-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20260319180525.136095-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/19/26 1:05 PM, James Prestwood wrote:
> Adds a new flushing method to remove all PMKSA entries for a given
> SSID.
> ---
>   src/pmksa.c | 27 +++++++++++++++++++++++++++
>   src/pmksa.h |  1 +
>   2 files changed, 28 insertions(+)
> 
> diff --git a/src/pmksa.c b/src/pmksa.c
> index a50c8208..9b02d7e4 100644
> --- a/src/pmksa.c
> +++ b/src/pmksa.c
> @@ -213,6 +213,33 @@ int pmksa_cache_flush(void)
>   	return 0;
>   }
>   
> +/*
> + * Flushes all PMKSA entries that match an SSID
> + */
> +int pmksa_cache_flush_ssid(const char ssid[static 32])

const char is confusing here.  Either you're passing in a string (const char *) 
or you're passing in an array of bytes (uint8_t */[]).  pmksa_cache_get() uses 
const uint8_t *ssid, size_t ssid_len, so maybe use that for consistency?  Or we 
can switch to uint8_t ssid[static 32] everywhere.

Also, just ssid is not enough, you need to supply the AKMs to delete.  If we're 
'forgetting' a PSK network, lets make the effort not to clear out a potential 
802.1X network with the same SSID.

Regards,
-Denis
