Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFF7472
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/Tf4OMi"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b7a9f90ee9so191937039f.0
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 17:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703036957; x=1703641757; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlZirXprOVvDjPASb3T5h68SGSwa0/hY347pPF8VxQo=;
        b=J/Tf4OMijcj1fA+McVHC/kZXn6fmsFq++FmDI5DOnn3wTwtaCPh2kWvgFs/R7ogzz7
         U7C6MgCYNGXJa8K6kkYPBKt62h1REE2c09De2pfmZ5ntY0bg/9Zk4RqxQqqZLXYZ67gQ
         /117q9csjueUh/yJUg3gDPy3PpvBIterep81gqO+N52M9DIiUqNerEluOun0Z/Leah2W
         tEsJ3sdUgJf2ap92O5ZTemdZ+HXYSEUxilHJQiaVn7j1Fr+A+NIgdEp/leDlxmliXCyb
         vQspyjKXVYTWeCOSAWvdwsXXXJImDbRNDQiPuTpTE+vAfDX2flc0EDppMU10Raws6kwg
         xZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036957; x=1703641757;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlZirXprOVvDjPASb3T5h68SGSwa0/hY347pPF8VxQo=;
        b=nT2cHzZ3LRbApTzvMWq+ip/QIxXp4oGOtm4a+ErNQa9rL/Nm3Ei52N1qX9honXW+xH
         145FjPKHiI3sUHmbWF/cF9xvVI2A9Ki1eLPZ5lwn74ZVjKA5THMWIPTV96uBOb7fg1uT
         4OJmGFhfzQGnHs4wbWr9qI7qNqmKfRKrbHOXfYpEq8hUq8570ffxghK5LA/Qn+LTfXBD
         AsJkf6PnA+QV1IyjK2Jvkcd6ZgI6kWxOlYtaLZVZS/G0teR9MzQffGzfDZoZ6Yo5XGAx
         BabVFE/j30gK5CZamlxtDL8Ingfhk4Jjq+nwmOTP10Tp/go1hYMKCmQ6D30dQGgT5pGm
         en0Q==
X-Gm-Message-State: AOJu0Yxja2MRvtPPtVQbDpRJP2/+vfTD40ILIBPU7nKk8lDlVrEgOpZg
	tSTvJJv8EP6vC90/zcbrk8w9JITNxfg=
X-Google-Smtp-Source: AGHT+IFlZqCVDNXpzL5IByPIKvKCH/1D9V4i9ph3L0CSfz2NlTNAEgN5I/iB+1SY+3DD0CeGLjTpMQ==
X-Received: by 2002:a05:6602:4c0e:b0:7b7:1c30:bc1f with SMTP id et14-20020a0566024c0e00b007b71c30bc1fmr21525562iob.13.1703036957266;
        Tue, 19 Dec 2023 17:49:17 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id w12-20020a056602034c00b007b45c1015b6sm6512094iou.31.2023.12.19.17.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 17:49:16 -0800 (PST)
Message-ID: <9087dbb3-77db-4e29-8b92-49f156d1f5bd@gmail.com>
Date: Tue, 19 Dec 2023 19:49:16 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] knownnetworks: Add UPDATED event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231219180826.201540-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231219180826.201540-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/19/23 12:08, James Prestwood wrote:
> If a known network is modified on disk known networks does not have
> any way of notifying other modules. This will be needed to support a
> corner case in DPP if a profile exists but is overwritten after DPP
> configuration. Add this event to known networks and handle it in
> network.c (though nothing needs to be done in that case).
> ---
>   src/knownnetworks.c | 4 ++++
>   src/knownnetworks.h | 1 +
>   src/network.c       | 2 ++
>   3 files changed, 7 insertions(+)
> 
> v3:
>   * Removed bulk of this change, just emit UPDATED to let DPP know the
>     profile was seen by knownnetworks
> 

All applied, thanks.

Regards,
-Denis

