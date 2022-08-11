Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654F3222
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 14:41:03 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so1761163oti.9
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=w8uyS59TeGwm99VdpL+u2mXRPkC8BqXU/g5HiX1XdYQ=;
        b=g5M0HEwGZiS2QdRIX8XKc976Ph3IXNm0qttKh+ZZs1RIqCqWyFvU6fGdhMD0w1zsoa
         +nKeaZqAgOMhV+XrfXktmKQ8nz2o3oq8C+lRYiKTrXyM22E0XnifoyPiFBUqa+6pJgNV
         MQnWkMiOpgXZWawuhXBjVmbZuR8FdnYxt1fJx9Tq32VtR0STf719y5WYWDcUF9VE3U5a
         l0KnZt6zCB0UWrcEt3BqpF3zvd5Rqnv1bjcmYnqz8Vd7IdQ0XY3tP6ayRGEqPinlusdo
         O0/km6yj9svqVr6eKfbnEDFX54+GGKdJ9mCQrMxwI6eJw9EW7+wan4sLSaX0myl2QVPQ
         L7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=w8uyS59TeGwm99VdpL+u2mXRPkC8BqXU/g5HiX1XdYQ=;
        b=1nbojzka7DBnrn89pnlECMs+OzTQ1JZ+q0Qm3PL61t80Bre64Fhl/Zh++6H1diRUPE
         16HufuRi59ESXoqVzKP3IB+qBMJ7lzAI0FCmpXBVQ2AZrxA3fQ+Kq6NBn/G7yhl20HPk
         9Sl4nwRFh+/5ouV+PSxTv3U6+WuFN+wcPWyeMwPRlqGcZVrzFUfCC8V7fLUeSQdRo1QX
         yKbZgpKXuUrLS7q9oQ8x45wOTVpkSxSeM0ynJ1luSbQFNhLLf8m2hl2+Rpl94l3XEVgU
         Zz68lnYAaBa/0p0iwfN5jBYodQzHNq7y9zpldrtwNd9to5rDzbUaCdspI4QoTKs6VY5H
         UPIg==
X-Gm-Message-State: ACgBeo1XP8XjWrul0vU191pYfsEMDqQeePWeiwH7hXjW0F1CtiQylAiU
	PBRSY2xfg4GgDTuK7WTFRpw=
X-Google-Smtp-Source: AA6agR6XqoS2dwh+04G+4Yel75vEOwfnaFDucR0oJEgClw8eLTseT/1TCm4Qboa9eD2Z5FuxdGbEkQ==
X-Received: by 2002:a05:6830:621b:b0:61c:f67c:556 with SMTP id cd27-20020a056830621b00b0061cf67c0556mr12546171otb.221.1660228862827;
        Thu, 11 Aug 2022 07:41:02 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k2-20020a4a9482000000b0042859bebfebsm1111612ooi.45.2022.08.11.07.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:41:02 -0700 (PDT)
Message-ID: <fcc47dba-fe1e-ea02-327e-006169bac4af@gmail.com>
Date: Thu, 11 Aug 2022 09:40:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/8] client: add developer mode option (-E)
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220810231621.372514-1-prestwoj@gmail.com>
 <20220810231621.372514-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220810231621.372514-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/10/22 18:16, James Prestwood wrote:
> This puts iwctl into developer mode which allows IWD debug interfaces
> to be used.

Why is this needed?  Can't you just detect that iwd made Debug interfaces 
available and enable these automagically?

> ---
>   client/command.c | 26 ++++++++++++++++++--------
>   client/command.h |  1 +
>   2 files changed, 19 insertions(+), 8 deletions(-)
> 

Regards,
-Denis
