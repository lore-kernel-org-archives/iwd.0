Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3614285
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyDnAh1f"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e9ac336589so643991fac.1
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697815429; x=1698420229; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsYdpAv9Glxx/b8H8G4m9xs6w/g60LvdxjL+sQRfuIQ=;
        b=QyDnAh1f2Cp+08llfaQiR6wu/iV2HMOfT8KQJ2SUIZ88z3SP4FaBgClmVMn/BUBfck
         dqPizBPYATfOTMs2oP6cHSQQhrTt/TJA4He9/f8kB7WKWRM0It55Shdv5VRDzcBW2p1c
         QJVIbX3pHGDDEwtTUcDYV8OJqdR1//64IIKSSlJsUxmyL2V0VZYJretQ07W6abTpucvm
         HOgo/dceTo4qjk5aymKEjs6kzrjGJzCimtNERU4Q/LS5meAbx5CZHFXTrauQT2dr4tFW
         Ju2Nq3TufgNUdCadO4eAsptghQPxNApR1x+a52dY4FZhkrl2yCKRRbrkR2cLQiihZlfn
         nadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815429; x=1698420229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsYdpAv9Glxx/b8H8G4m9xs6w/g60LvdxjL+sQRfuIQ=;
        b=hJ2teanWbRKpkC7PmLEWLxyDvcPCHPNHxOWRGpQif8sVJVo8B9RTkGIUW8lNRrNOq4
         gZjpdk4uU9xOphNwhCwO6UmjVfVq4T7CFN1+N+z6lzZRGU8D7DEpyKlx3pWKeL95vyw4
         us8dw4+hA9XgASDx+U8G3u6QmFToXI1zuwVFGfRsioVx1jE9d0HNZSwAFVdly9oY2R4k
         kG3+cFhQlo6J5O6ANgOd72XQC/46nt7vPAm1d1hx2x3ZV2JahnFWU+hPA6umNac2uR5P
         46LM/p1i96/tth/ftPU46pLwGVmJd51l+IzMS6SmENXdAbe7681HXgQb/n+asnaOsFU9
         7Gug==
X-Gm-Message-State: AOJu0Yy+tq1qTp0wfWB3SCHyFBMOiPq5mpfuClMwuNKk35smHmdcdzzS
	/d8FZifFzr4dntNQIWIZhQJmfnZiV8g=
X-Google-Smtp-Source: AGHT+IFAVkG0LnxpD+A+ROnoNambgVoB2/JoVbyWTfDJhBDFpqLte7qxDh8Pj8WbgN8x5dFwxeitZw==
X-Received: by 2002:a05:6870:1394:b0:1e9:db04:eb51 with SMTP id 20-20020a056870139400b001e9db04eb51mr2317698oas.39.1697815429723;
        Fri, 20 Oct 2023 08:23:49 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z7-20020a056870e14700b001c5a3e31474sm398788oaa.45.2023.10.20.08.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:23:49 -0700 (PDT)
Message-ID: <1da9ae9c-60c4-4d55-9d0e-2ee988331a2a@gmail.com>
Date: Fri, 20 Oct 2023 10:23:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: fix unintended netconfig_reset pre-roaming
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231020125021.107671-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231020125021.107671-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/20/23 07:50, James Prestwood wrote:
> Commit 23f0f5717c did not correctly handle the reassociation
> case where the state is set from within station_try_next_transition.
> If IWD reassociates netconfig will get reset and DHCP will need to
> be done over again after the roam. Instead get the state ahead of
> station_try_next_transition.
> ---
>   src/station.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis

