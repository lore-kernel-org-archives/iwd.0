Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3D7C
	for <iwd@lists.linux.dev>; Mon,  3 Oct 2022 15:33:21 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-131ea99262dso11085704fac.9
        for <iwd@lists.linux.dev>; Mon, 03 Oct 2022 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CF9dNWv9/Oqe0SnU0N5jWA+2yJ+TtZj5zbrLux7P1pA=;
        b=UP6541mYMrlOFMAm4XMuOeM0r3mkt+hcfb9TyQG9zPK4TA2NEEy7r1KTK7iZdrOcn/
         ENGScQRU6L6IZ1B2pVFt+XBHYGzPGndN2dT8RvLjwujFMSDzD97cXUq3eS35BFSTlpb9
         sj3E5alcVEChigHiGXwZM63AZBS6oiAIaFBzummlB07a6dU6OJcNRLJNULcN3h4PjtZ8
         JVif28OT+Ji6SSUmLdvmz5+tJ3oy+RkPoKEADEOJjs768ut+MyDGCm11qZsI56u39oYv
         qp/1MSA+Bodos90YgJ3S1aDAgfJSkYy1r2IPnED6NSv9tE+Qso+M5uz1ciXPjBP+gaPG
         kE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CF9dNWv9/Oqe0SnU0N5jWA+2yJ+TtZj5zbrLux7P1pA=;
        b=u6fiS76u2Td+hsr2j95f+C6i90KY1TNdN2dGiYMERxpp06fV+HdK/pM3PCRhobq1Rp
         +3EOpwgOVIdHqvIACthL83L/DS9vc6Zo4IBh6lJ1XlU2b3OcraLOOqC+qjmqXy8YyvT8
         yFsepYD7yja7oOsAW9h6T795mma6zDiEAitrqN3GSIuA3FGRHSJeWua/fXqRaNV+ACdd
         yMgRUxezP0eQZyDRqtBj1kZ91gRhh4GINpANe2eGmTJxEiW4ZsASQwkb+0I43z4v4XJ9
         1XekU8osUYGP5i8aivM4osSEz6+S8y2cAdFm54ZRZvaZaXrgadhx+w8+1gyELlY4VuFu
         mNyQ==
X-Gm-Message-State: ACrzQf1CWHcjDn5Xuhr4XmyjlsOdHf4a/n6jYpuSD27+45pQsT+7kpgH
	LuGdQNFsV8cs9R1DcevSZ7NabQOZZkY=
X-Google-Smtp-Source: AMsMyM7iBB7YwWgvYo762bdWf4CcaD2Vvh6uqQGqeZjYfOVGK6Cz2oWypmTSuOLcG01RmLMyZ6nx4g==
X-Received: by 2002:a05:6870:f228:b0:12c:c6b8:51a with SMTP id t40-20020a056870f22800b0012cc6b8051amr5705817oao.119.1664811200797;
        Mon, 03 Oct 2022 08:33:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x93-20020a9d20e6000000b00657865c9827sm2497210ota.46.2022.10.03.08.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 08:33:20 -0700 (PDT)
Message-ID: <f3382844-82ee-d0d4-bf8f-de90d8cd8070@gmail.com>
Date: Mon, 3 Oct 2022 10:33:19 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] station: Handle NETCONFIG_EVENT_FAILED
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220930144801.548229-1-andrew.zaborowski@intel.com>
 <20220930144801.548229-2-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220930144801.548229-2-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 9/30/22 09:48, Andrew Zaborowski wrote:
> If IPv4 setup fails and the netconfig logic gives up, continue as if the
> connection had failed at earlier stages so that autoconnect can try the
> next available network.
> ---
>   src/station.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

