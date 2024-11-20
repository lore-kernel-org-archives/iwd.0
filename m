Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8B15573D
	for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125151; cv=none; b=gnqI7Qfk27SVWZyJdbyR0pgasKMkluc/GBkb0H2ClA8j1KCEj+zt/yG2ZlvB+L5uPhouqNmj6867x2kJ1EYCpeBkTc7PIdSKBaycP5tK1s14C6aCZsQSqM6cddbNaHc2HzDgCmy0N6Q0dIjTSRHJBjYL4qgohOXksdKMkKKqjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125151; c=relaxed/simple;
	bh=DQyO3MokP4uGmnvAEQzpmx08Uby7mH+ruDkkyP9PHEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oh0n2AkN1BSEYiGxkVGbB1ldNixJG+UPvrhRV+x/28f1xIY9+dtrqbpJ+rJgS1wImhi8YedTC7+fpKz+5K1G484q3ekOKplyhABxHxkntXCDFd9fTZfV9T40ejIZEwnphpwBNOeEdP3bwkvBL3xVBU3g2zPH4yoVREBoZeHaL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBQMhkP9; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBQMhkP9"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29685066b8dso51632fac.1
        for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732125148; x=1732729948; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyAOZ7N3Bua0tnq5Z3vB386pu9EuMtXdC7eDPVztCP4=;
        b=nBQMhkP9F1KR+jvIcZJjxUJBGZtbZwbGGbHC/MW33/YY5WVbOcUQBt55vGv8Dp6rSV
         imogbi8T7SvXXhtrYbOcY1DYkA80q1PLX8QTXcUX6tQYO9RNvUsHph8cFJ1rAGTV4jCA
         O+3OcI11LZLo2hozHxIWcf7oewQt0hIYRN8ggCRw2bxDviIfPMjkagJ4c1ux47YRZbGo
         rm5NUgvYrNkxZfP5jOLon060QGX5zW7hp1UB6x5pN3Y774e7Od+UMG7auDsuHjD8nk2t
         dxypEWB/ckJJEyhrOqN2i6P8gtwdIIXFJB8QbSwC9v0oKOVOmXivGCwsPVvEtmIcdrk8
         98gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732125148; x=1732729948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyAOZ7N3Bua0tnq5Z3vB386pu9EuMtXdC7eDPVztCP4=;
        b=oWnxWQGv/L/pSsWHgyatlkg1IwF1O5Eykw6wAfwGCiCUmXwFy6Gem8mnyNPX+qjuNG
         LO3RJga4Y4HYTzMqyZG3dZyuZvn2gmlZxuw+1ESOmbw3V20+qZB8BuHEF2djSamhyB82
         N7O8rPI8rNGtZvSIIs0tPFA0IYVHaEbNc8IsnoRYyZiMqhC2jw/w/0OVuWg506/QlvGy
         9mMM3Vfe2I8mqiMo79DBPBjU8zu0je9Ta7Hnmg3ECXhiU5qxbSJmMi3rnN0TJuGpLIKC
         QJJ9DrgTXQyqy3BkoQElR0mL+DONfuJMyExLEZPt97vkHVyQUEPQkv0V4dec4iIClFQg
         95jA==
X-Forwarded-Encrypted: i=1; AJvYcCW98vfV84hoB/KwzNLIg7GJ7vVpVz/Eu4qpzyip5cF5TzjsE7s75yc/1K5OcGVFMMhXxws=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywibi1TpWR2JZfS5Y0deEO6oC13OW5gVMVrghPT8e+6GXhlADt3
	bHZlA4C9sWZGF71ywMfAdJcKg6MOrr58veF62VYgGbwVTYvlGdaS
X-Google-Smtp-Source: AGHT+IEd9XLgl/sTEVCanFSLvXBnxQEPyXOwCyD+4jOMCR5jZIj8BeA1ZV1i1GRVZE9rI3CERXELSg==
X-Received: by 2002:a05:6870:7d84:b0:296:7bb0:675f with SMTP id 586e51a60fabf-296d9a6625amr4074603fac.6.1732125148662;
        Wed, 20 Nov 2024 09:52:28 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-296519399b4sm4319521fac.26.2024.11.20.09.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:52:28 -0800 (PST)
Message-ID: <be4d7e04-6421-42bc-8c89-0f7d9a8f3d58@gmail.com>
Date: Wed, 20 Nov 2024 11:52:27 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] util: add util_exponential_decay
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241119142430.323074-1-prestwoj@gmail.com>
 <20241119142430.323074-3-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241119142430.323074-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/19/24 8:24 AM, James Prestwood wrote:
> This is copied from network.c that uses a static table to lookup
> exponential decay values by index (generated from 1/pow(n, 0.3)).
> network.c uses this for network ranking but it can be useful for
> BSS ranking as well if you need to apply some exponential backoff
> to a value.
> ---
>   src/util.c | 28 ++++++++++++++++++++++++++++
>   src/util.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/src/util.c b/src/util.c
> index a6ab9d85..b673b002 100644
> --- a/src/util.c
> +++ b/src/util.c
> @@ -636,3 +636,31 @@ struct scan_freq_set *scan_freq_set_clone(const struct scan_freq_set *set,
>   
>   	return new;
>   }
> +
> +/* First 64 entries calculated by 1 / pow(n, 0.3) for n >= 1 */
> +static const double rankmod_table[] = {
> +	1.0000000000, 0.8122523964, 0.7192230933, 0.6597539554,
> +	0.6170338627, 0.5841906811, 0.5577898253, 0.5358867313,
> +	0.5172818580, 0.5011872336, 0.4870596972, 0.4745102806,
> +	0.4632516708, 0.4530661223, 0.4437850034, 0.4352752816,
> +	0.4274303178, 0.4201634287, 0.4134032816, 0.4070905315,
> +	0.4011753236, 0.3956154062, 0.3903746872, 0.3854221125,
> +	0.3807307877, 0.3762772797, 0.3720410580, 0.3680040435,
> +	0.3641502401, 0.3604654325, 0.3569369365, 0.3535533906,
> +	0.3503045821, 0.3471812999, 0.3441752105, 0.3412787518,
> +	0.3384850430, 0.3357878061, 0.3331812996, 0.3306602598,
> +	0.3282198502, 0.3258556179, 0.3235634544, 0.3213395618,
> +	0.3191804229, 0.3170827751, 0.3150435863, 0.3130600345,
> +	0.3111294892, 0.3092494947, 0.3074177553, 0.3056321221,
> +	0.3038905808, 0.3021912409, 0.3005323264, 0.2989121662,
> +	0.2973291870, 0.2957819051, 0.2942689208, 0.2927889114,
> +	0.2913406263, 0.2899228820, 0.2885345572, 0.2871745887,
> +};
> +
> +double util_exponential_decay(unsigned int n)
> +{
> +	if (n > L_ARRAY_SIZE(rankmod_table))

I changed '>' to '>=' to avoid overflow.  All 8 patches have been applied, thanks.

Regards,
-Denis

