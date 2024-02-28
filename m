Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7915DBC7
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142711; cv=none; b=WyoXUGh1qT+Tb77kF+ZpyI3t78TjmHRkq978zXlSJP9jbUiJXBxDNXxPWIwBYo0YY4wm9aEnSKpGwncUr77drUA9UMdISSWU420CwRgNSLmoqOMOSMGCY708o6LhCFw/MrIFkKikNr2TNtl4rxP6TnhtznOv8jlsTOTCz4xGiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142711; c=relaxed/simple;
	bh=dbZgiiv/KKpqm652qsp+XWGr9s9m5UE4THQF07RI0GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jGUugmv2ueJyOO/sgBUnLZBM36vxLpVUDOuip35/+vEgaWzDgIm/bYOauBkcHCZ4K0hc7vWsHBQs7dm0SlxCOQYu3eYX18XCgh41/Wz5ilH4Hg77nKGanYo3UmLn6rm8Gl2TyMDUun+T8bun3HTwylxl8XoXLgbfrR/2fYzFnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmRPCJb1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmRPCJb1"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e49518f375so1901059a34.1
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142707; x=1709747507; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fGCe2VH9wqOelUX/O9+6smkcr191XmH+eW/uZrrFD8=;
        b=bmRPCJb1S9YCYRxPqHv+s68SPRK0dR3PCZ4Lotmj+Lm+v3nhj2DRQmJQOoqGlUgo4f
         TGkjyU4LwwvhdMDP3oMKXz7YnEV2U8tErtr3pMIBEbtJPOXIOam9IvHgzZLMyQGj/D46
         +jeLSeuKF9mUB0aWiy1aZumjJb6CF13qzcax0jFtXmiMdh4zq7TqicNQIsMkl4RMgTug
         h6psfpD2QCyfAiIqcPD5uSonabvT6rpwLFErH4TAqvMVubn6aH3t0tNeuZdtLn6Z2gMF
         6vtNY01wKfbMi0uB2sM8YIqtmMLbTjsNwIbuf806/kOB3P/l1AqbVIzITR/0vBD9SiE/
         lHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142707; x=1709747507;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fGCe2VH9wqOelUX/O9+6smkcr191XmH+eW/uZrrFD8=;
        b=ldmisU+iKZgihEjmxXTKRmz9tP0GqvOCcuresf9/XOEypbYkMRJ98y18y7SsmVOw7M
         OP8hNCwgV0nW+BKm2QhIVEv5lgewdmxSJNiuEQeEn8cHvdD5j1/zZMGpwHh8fZ37OQpH
         eNIEp/HMIAm27U62571GfK6ITOBI1OM7FnwbCdZ9UAAe76TBlzBhMDcL8J3fqdDTfcZe
         qT10fyq1oUziUQsXingZNeunIg29yRo+U1wPF9Sa4HSJWw/ryBrVmscVwiy8TnxCNMZ7
         Vew+jsDQXFVaXPtIforHdTP/AUW/fQJO1ah5TVVbPHoohhhI5CumehhkL/CsFhfzjB5F
         S7/A==
X-Gm-Message-State: AOJu0Yy4L3uvZx7P3zlsVLTUjlsluEfe1f6RWQNXE3oWXdZBKm0XooAb
	cLlNPX9GTGn9ODDKor/36oaM620316m2/ed16jeHzh8DWxfgBRF28+R0g+i8
X-Google-Smtp-Source: AGHT+IFWC5YH7ysS2WSqPrqjnwvYn2lDCpkxXdA8OHgp5IVoN/c5kA0wfd/ZYqlSwQMJbxm0cfW3Uw==
X-Received: by 2002:a05:6870:538b:b0:21e:6b78:ff43 with SMTP id h11-20020a056870538b00b0021e6b78ff43mr490021oan.39.1709142706775;
        Wed, 28 Feb 2024 09:51:46 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ew10-20020a0568303d8a00b006e43f8eac57sm1977617otb.50.2024.02.28.09.51.46
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:51:46 -0800 (PST)
Message-ID: <779581b2-72c6-451d-8315-e7a587dcad8c@gmail.com>
Date: Wed, 28 Feb 2024 11:51:46 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netconfig: Fix copy-paste error
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20240227204242.1509980-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240227204242.1509980-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 14:42, Denis Kenzior wrote:
> netconfig_domains_update() was setting dns_list instead of the domains
> member.
> ---
>   src/netconfig-commit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied

