Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FE145341
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086443; cv=none; b=pZGmk44u7HwG5nOaPd5nMiIngc5W7FOLLyVhQlZ+xS2xZsIQODzLOa97c158dBA4A2PqDgTglytYSvZ5VRzy1AM60gIudgQ0ptzM5AjbYq9/sr/GhXtY2K1n646pieoI3gCIMGaQ7Mlogqd2g4d3TgkL/0loqstPBg+RekVjsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086443; c=relaxed/simple;
	bh=zBKsgLuPCTLZMHgRWgtFs7gAU9/9OgexJywrId/VzbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WZipQ7Tc330riVvhdIruFk2/p7E+7CwDI+Wb1BIujFCMv4EoNY7NSPf6thfwK4IyKzp70PjrHTJIu/fKz40DfFkXm08PBnArLrk1xtjo8wiaG5Q3aJVaSB8OPg1gqObjhVJ4PIl3Opd/SLdiItZ3LifKgvqQ7EEud5B9VPRAWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naLeW60X; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naLeW60X"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27018df4ff3so2667412fac.1
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086441; x=1724691241; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kbw8oDjG1yYXM/xXdHFzXunkbSGGORwS9QN11/CR3RY=;
        b=naLeW60Xvo83XX/uZF7chssblbQpdo5JRDPVbB+KH2+Spn+53EYdimkWaZnjktkX28
         4VCgFgen692keir/dCng0W6KyT6We8/e4YywNY2hWi4OPrpFfx/LyRMsmVCoydqceFHP
         CzyQIbsuFE/C61WNR1Ks3i5L1keEI6MQBSer9Wr4ijQJo7U8IExsJ5fxIrLNXGS5pwgI
         cfdosMZ1MdIkJEd/ffXCcKb3ithoXw2HvWM2Uy8Bxk5mVKHDfZ1xaV9r8UoHihGWhglm
         BntMm16qapQcV7v37AeEugSx6nFaWHUuOaU0jG2a4jfMqVbQJCAwxhmMAQ62fMqCy4zG
         SiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086441; x=1724691241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbw8oDjG1yYXM/xXdHFzXunkbSGGORwS9QN11/CR3RY=;
        b=WZZblEL1vSFTXnSveV8keTvkDAejyycQQXmCcrkm8BnxvEzoQA9q+MreH9FX+1P4GD
         okmhX+BalRlxLeLJcKbvYD8esWXhMM+mGsgpbsbc9BHYkkplEl+NkYdAz2/Lhb5CsGFC
         jrofz1L1qLCrOcRZgu/garZ5wmiiISzrhc2a4eEVJY+Q8cBotAwtlYqcU2XlLW/pzx7F
         weUXaicoCjh1on++spgZz6hgJgFHDnlrHaMaSGHMGGDJ0Qh1Ge9EdbsvGw1n3VuCzkUi
         MOQ+wWMri+m/RynhFoOahPuKMniRk0rH7dVoR0DGJBqKzdkPjlhG3Vn9XIqR+0O2g+Kp
         a0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWoB2yufSHXRxoGsE78etFqbUZkl6SbGezdBqaTrZjit53s2Vn95lW15IXtvixmlW5cLg0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ+4gGkVOwZpRlu/r6fzWldRBZMMoRjIEvRKifziZ6CinpAPl0
	OfA9eiKV1JSB4bAaHh84qxfL5uy+NtltRBSmskYPBeDDo0Y2XlCx2RnD2Q==
X-Google-Smtp-Source: AGHT+IE+kDIVVf0SA+2PhObzCWWP0pkCTygYLdPcZLg4uBrzs2MV6wU/+vjDdf4bXbFavKRYBSFlYw==
X-Received: by 2002:a05:6870:2183:b0:260:f9e4:1fc with SMTP id 586e51a60fabf-2701c3a1c26mr13120599fac.20.1724086440719;
        Mon, 19 Aug 2024 09:54:00 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-270046c0082sm3027634fac.31.2024.08.19.09.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:54:00 -0700 (PDT)
Message-ID: <3ee992fe-da50-439b-85d4-be7c10189512@gmail.com>
Date: Mon, 19 Aug 2024 11:53:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] network: add __network_path_append_bss
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240819155734.1276476-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240819155734.1276476-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/19/24 10:57 AM, James Prestwood wrote:
> To reduce code duplication and prepare for moving the BSS interface
> to station, add a new API so station can create a BSS path without
> a network object directly.
> ---
>   src/network.c | 12 +++++++++---
>   src/network.h |  3 +++
>   2 files changed, 12 insertions(+), 3 deletions(-)

All applied, thanks.

Regards,
-Denis

