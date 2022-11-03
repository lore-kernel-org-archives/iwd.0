Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC167470
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 14:25:21 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so1059519oti.5
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wixFXmPg+aEMiDxgsEhh1lR5Eyx0v0UEpzcHjfIX9Gc=;
        b=k0wWGEPQSMfNMJjdaAnIwTSN6pmfq1KQW+Ladruh3pTfAcZSzsyWG5o1N6RINgO5pr
         fmXc6iAszsNFukZNtd0Fe3lIksccOwsD/6VbmZ4rD3rZn9oeNGW5ImO2dBKyW3MLdpB7
         ADwB/ri5xgdZ8f6CHgFNKisYhLNawtvmwkGn43bfqDtZMLjs+yASKAfbP6+H1TXUt/td
         cfV7icZoo4zvOWxOqLN+czxOoUOKL6jv3FSqJ4Adwa3RQh2FRFk5c6nqpdfUzmhNI1AA
         fiJUl2nMu1VdNDcIF3DdOz46uKFNBnFPpzpoFrGyssBEXKOJeroL+ZwILc1gv7GS+tMn
         F9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wixFXmPg+aEMiDxgsEhh1lR5Eyx0v0UEpzcHjfIX9Gc=;
        b=xE7lbYHaUQ2mduEU8YuWKZnKmUahR2+v8ufRkWAUfpdphEwuqnMmP5TA7B/84pjJdg
         RH3JF3PiNxhepITXJHQsG6onAZWtluzUKXrOrioL17O88u4R+g/P4jh6geEa/g6WsMkV
         RNhQi1EKSIWEq7v7yoF75nMekSUzjZiSOdgSAYZmkGa+IId2oH8/3f/MK8m7/xBpHiMq
         vm/AC495L3bYi4U13YPf/QcbqqdwgI3SRf9K9yAU3lS0yKvarVEx+lOpjtdjscsxKwl1
         mIF9TDYn8RfcAQsEndV2v7X12XZWaybDMo/DEuk91ZW4UOYL7Y0RMIFrZ40oeoTd3SaP
         K4gw==
X-Gm-Message-State: ACrzQf07yEtk1YVtQeV37G3CIUo9Qxpk1eAepu1WLgJsoPKA7Zna0tAu
	Slx8A7Di9T1193IHuzqO0h8=
X-Google-Smtp-Source: AMsMyM496MRaeT7svXc072vBYbynOTCqZBwrKnF0pZOJPa8qQSiceM9ZnP5/30t/Q0l+Jzow5e91mg==
X-Received: by 2002:a05:6830:1ca:b0:66c:423a:cfa3 with SMTP id r10-20020a05683001ca00b0066c423acfa3mr13436206ota.199.1667485520944;
        Thu, 03 Nov 2022 07:25:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bp19-20020a056808239300b00359f7f0753dsm445824oib.14.2022.11.03.07.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:25:20 -0700 (PDT)
Message-ID: <23fe910b-5876-fbd2-791b-2c1ed252dcf0@gmail.com>
Date: Thu, 3 Nov 2022 09:25:18 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/11] ap: add PairwiseCiphers/GroupCipher to dbus
 interface
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221102225116.297129-1-prestwoj@gmail.com>
 <20221102225116.297129-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221102225116.297129-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/2/22 17:51, James Prestwood wrote:
> Expose these values on the DBus interface so clients can view them.
> ---
>   src/ap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 

This set is missing the API documentation update for these properties.

I went ahead and applied all 13 patches in this series.

Regards,
-Denis

