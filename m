Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C733C7
	for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqUNRoco"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so2639074a34.0
        for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698617228; x=1699222028; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMNMMhm8dwHlH0TjC8v2/htxFNWwESq8xDKSh1swrLY=;
        b=EqUNRoco9yhGNkSWAyZzCcW38GinXrR+3CihqCqREaebsK4qSfmibTROevIJeFoJNJ
         fTGvL2fZMCtaqk9OuJy0G81KLs7J9g8GxRtN4/9VXf9Gv3yYKdJbbcSPF9bmZA6YQaMe
         t7kxwn+JSyjUM6xmXZUQEjTzt0oFm5EF1Fl0ZMJQgwO3/RLK1+emFsMPycPJ/JfQ51d8
         NYS5HRTQH45SxYnaX7VOorYTpCpmgLIMXzM6KgvOLGtGLgbl5xSembaKGCBF4FaVrI6n
         URIEdUTIJn85xJwHr9fqS4tJm7jZcT/yOwL/gH53O8hAOn9C6h99i3O968ch5Hven6aA
         uO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698617228; x=1699222028;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMNMMhm8dwHlH0TjC8v2/htxFNWwESq8xDKSh1swrLY=;
        b=XLeatnVlmPLCmWWnqqXJaVgoR7Ub8ao5Qz/1W9Yb4hCUptEvcVEIiw2RZ0zBCJJZMy
         vSUQM852S8+W/yKck/0MhsUDF1y/6CSWXGvolRoCg31Z2Brez6czUIJzQ4c2G9uUYN/H
         1GXCnxV2tHqKX22EyBvrs/7Z21tcaOCKPXCxV8YTW1DR5/2cQU5o+whz3W3vdNGQlpU3
         sQ5T7LuDFOHo7SrRigi5lyC7xoKvsUxTumVcHdIXufNMEkAtfAyO8AQbE8bVi6cHLSrX
         OhiUWcJeI2Zuz6QD76d9hwfv0OvAcl5vSKvniAqLfjzdIod1j2BRX4zSe2o29Qe4K6Zg
         J9/g==
X-Gm-Message-State: AOJu0YzQLOwliEi6nh7hOT9hLgQ/XmLncHdGsfn78mNGI4m+nEprvkFE
	FEAtgkYSxrvYc5zfIv9dwQc=
X-Google-Smtp-Source: AGHT+IEs4bnDtwVy9Is8bDWxXodPGjAirK4hq4O5eHa1pLZ8SPG1PwS4hAqYSyQsjaPBMDIpIRHRWg==
X-Received: by 2002:a9d:6d18:0:b0:6ce:1fa7:fa0c with SMTP id o24-20020a9d6d18000000b006ce1fa7fa0cmr7724356otp.30.1698617228634;
        Sun, 29 Oct 2023 15:07:08 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p14-20020a056830130e00b006ce2cb3b959sm1203320otq.52.2023.10.29.15.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 15:07:08 -0700 (PDT)
Message-ID: <2d35c99f-1248-4e38-b29c-a9129a9ec29e@gmail.com>
Date: Sun, 29 Oct 2023 17:07:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] dpp: check configurator role in config request
 frame
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231026202657.183591-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/23 15:26, James Prestwood wrote:
> We shouldn't ever get this frame as an enrollee, so disregard
> ---
>   src/dpp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Patch 3 & 4 applied, thanks.

Regards,
-Denis

