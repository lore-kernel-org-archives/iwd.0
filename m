Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B051F75BE
	for <iwd@lists.linux.dev>; Tue, 17 Dec 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456572; cv=none; b=e3EVsqQw9Xqqp1KQf5OXA4w1tYrh13u1bMsLpBqVxqa+JuHt2ocR9ZkGzFRmHg7bIhLThYdK0R3C6EZVCeJkl74RPw7u6DvsVfGwqrUiKkh1j9kuuk9ddIy/je7x94vTZN25UGDYfp63zFR9zTb2jmKJlhybtp7EmbK/vkcohA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456572; c=relaxed/simple;
	bh=RzkCMml74UgY8eHvQ7EEtR/mqmBECl90jCYH4imT8Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lq6ALNvf8AJ6rNvrxh68nO0VAjLv5HolgH5dEoS7nNd5RtzmxrHB12TESiOXb+iQWO7IeJ3ufdcacz+SYH0SfzgF5TZyNqdnftmPzxuBEV/e1TtvGgD08lkBEHQ+POLaBQHHMnRdq/2aZtCvUsopJQhfTgLNXiUfg2T2ZxF0xGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izVOYHeM; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izVOYHeM"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso370379639f.3
        for <iwd@lists.linux.dev>; Tue, 17 Dec 2024 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456570; x=1735061370; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8705WwkwXTTXthjUIJfYgz19aMTpUh/UEpnnA3OiHYE=;
        b=izVOYHeMtvevXzAeLgAsXnifQGM2ui/DhYxYaYWWvx+1FWpWtyrEQ0ZrSBMxUveJHd
         W+y/VIW+r1jYuo9wJE5+c3dlJeKaeKfnObwYg3uyoGaxhcj5+CSYn4XQsYp4cIjGf+1P
         hwbfIqx716mkyKMrXMB6kG3upQjyXRTfm1bjeQE/x/S4wV60+c1S+RnJiGffHQ+kZuPs
         kJfELXlx/nTKxiMMtJ6slzta9L72bgWmo4WRbltHaB/LpiKz2y2c3H14/OTRK4G4rSVT
         W/diNL5KZ4sRVJoOlQg8SiPWsgBnw0cojcdKBr2IWO1rFppmewjHMj/hqIC3zuhofGj7
         Uz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456570; x=1735061370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8705WwkwXTTXthjUIJfYgz19aMTpUh/UEpnnA3OiHYE=;
        b=BaTyGebFyd4cXN4zUIW8zQp58oFmENLNL03A/yc/6PqbYNNuueWYjRYimVdxQTtDlx
         K/S3ulNuV8MwYwYq5lF8nEgYnxEGXP+4fzkjVMWm4ziM+/ZJ+AQ/hxU6DRRQxgSGNLh7
         6lBZ6j3pYsxEBJHBGQAj6u8qXTYt0RDSN66yhXkXGNpLoAc8ZmDjh/WXiqrkvg+Z8zOz
         KaA/M76fEnGT66aWxlvfJZ4Xs45jmYJVe+XK9dASutKRR9sfugiB6zwYl5oxpje/AgQ6
         ec2u704SpkcoQyX/0yuQZGt99hxoKvvOAHUA1wF2QJUwERXpm9YaWoFfqQl6FkvaKRre
         kWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAb7D1qa6IqaSdYVuWr4xbZF0d/TgLBqTQywCiYXI4pVWq293u7Et0+rLlj2sFQzSg3xs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ073hd5FDbuq49t6CjPsl9PxnRI2eRPJUq/EcTeTKl85Fkaq5
	DabAvd6kR1M2RFDattuaPHryfXCiUDRTWYCa6yvBcFx8gwvRL+gsZPV95Q==
X-Gm-Gg: ASbGncvrk6VhLqFRgxzjme1aoTqOR7+B5Jc8Z+F6tWDSc0KqRWBt3KIdG+Kd4zFH5Pl
	fuAkY4iBVQ2hNMr0Z9Qys5WKxOgTCneU67LW+Uv0svWOs9gAf6C1FHEYyxhNAmjLEtFLAIkiQuv
	DaRe87coxcjulbE0LoIL2rbi9Apb2Ljtuuk+vCEGEc8U6JaNjkd3btbtNpqUnLD+1cfxp0RXz4i
	NZGy3Qi6l9TdKynwQK3VFU/hNB7Rk5FB1BuZJfGbK/8ZcWmIpjelui07Q==
X-Google-Smtp-Source: AGHT+IGWY3koUG2E9iBlqlVvumqIr0iC21AhFTK9yIwynZjF9WVJHQIaT2v28PGV59+/y7D/4hqC+Q==
X-Received: by 2002:a05:6602:6d0e:b0:843:e11e:e7e1 with SMTP id ca18e2360f4ac-84756ce5c2emr33558439f.14.1734456569832;
        Tue, 17 Dec 2024 09:29:29 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-844f63b1af7sm185618039f.48.2024.12.17.09.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:29:29 -0800 (PST)
Message-ID: <39409a97-2774-4300-a1c6-af077ba05413@gmail.com>
Date: Tue, 17 Dec 2024 11:29:28 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] monitor: add --time-format,-t option
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241202145438.282998-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241202145438.282998-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/2/24 8:54 AM, James Prestwood wrote:
> For syncing iwmon captures with other logging its useful to
> timestamp in some absolute format like UTC. This adds an
> option which allows the user to specify what time format to
> show. For now support:
> 
> delta - (default) The time delta between the first packet
>          and the current packet.
> utc   - The packet time in UTC
> ---
>   monitor/main.c  | 56 ++++++++++++++++++++++++++++++-------------------
>   monitor/nlmon.c | 45 +++++++++++++++++++++++++++++++++------
>   monitor/nlmon.h |  6 ++++++
>   3 files changed, 80 insertions(+), 27 deletions(-)
> 
> v2:
>   * Fix compiler warning on musl. The switch statement checking the
>     time format had no default case which would cause 'n' to be
>     uninitialized. Its an impossible condition least with the
>     current code base, but it doesn't hurt to add a default to
>     future proof.
> 

All applied, thanks.

Regards,
-Denis
