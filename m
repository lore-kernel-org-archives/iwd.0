Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A524419
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIeB5mzB"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6cd0963c61cso1064295a34.0
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697727089; x=1698331889; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TjMCW6eFOVuK198MUs+7rx/sFMwGtisq645ZgHj/No=;
        b=RIeB5mzBTl3sQcOHxe58vZW9xq8Ua/YYmjTPuf/ohnKreQIhhlJ9RZAeoU394ZBGBP
         rF7AkuwpOG2yw5pH9tCjqjzmYYGPGx7veJTwj6cogb5Ck5ZizFA6jnG7DDRR23eh3sxP
         u1git2EWo2gO2K8a93ACtf6H0HcDCmeGkvntb0K/olIJLAdoNfJjm/wph6PoUT90Q9z0
         aWGO49Sp6Hm+K8tUDLM8dMRw8SCXAi/PxgHl0DH5LoGu66JhPegWtvQ3HtKjT3YrjrSW
         +h14LtEeVCEebdHvvgKL1YuKTTt9FdSBodt+7SPNxdjn7Nq0Ssk7WUAGPS1Q5wHsmFLp
         TOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727089; x=1698331889;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TjMCW6eFOVuK198MUs+7rx/sFMwGtisq645ZgHj/No=;
        b=sXVlZ8tsLf51qOdNcq/sNUgZFYGmQrMVUA4HXR8nDwMtVTxJU66RLLkSgek8T7i5B3
         IwPzZ4/vmC7JDMExJby3arifF9gSbiXfKD29RY9pepPcG5o8Sl4hTIoO7IkZmTr/A2KS
         lYKiJ5W9KJfWhqZRi5mzZJ5uXS+J30mzNeKYIeacKGmOSFWu9BMOPd7PoI3qiob5KjzF
         wiSgO6U31m9n3E4gfe8hZPBBsk32avuZMisj9AgCkLW0UAn+d05CFCa26iO9zH879XXu
         DNR5UP6+J32y9h36lBJXHFeFoaQSbQlshKhPgc3/rfj/HnxhcnNal5sYN19VzSk0qElC
         XKKg==
X-Gm-Message-State: AOJu0YzPsT0jo6scJZkomDaju1q/N+fafGfUY7ggayhaFpIBBmcl0Xkt
	FRncyKPAllX0sKweQlyVQ9v/e5AR2dc=
X-Google-Smtp-Source: AGHT+IGC3aQfs68Hie1p9tvHLLPlF+KyKVJTBJCI248bZ5U6YcLaaCJXxHuieA957eKEl/e+Ps8KqA==
X-Received: by 2002:a05:6830:1245:b0:6c5:233:fc28 with SMTP id s5-20020a056830124500b006c50233fc28mr2396697otp.33.1697727088686;
        Thu, 19 Oct 2023 07:51:28 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f7-20020a4aeb07000000b0057bcbc23738sm1058576ooj.17.2023.10.19.07.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:51:28 -0700 (PDT)
Message-ID: <9182f9f2-4752-4737-bbf7-d308136d47fd@gmail.com>
Date: Thu, 19 Oct 2023 09:51:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] offchannel: add support to issue multiple
 offchannel requests
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-11-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-11-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> There was nothing which prevented this, but due to the behavior of
> some drivers multiple offchannel requests on the same channel

Isn't the point of offchannel API to serialize all such requests so this does 
not happen?

> resulted in the second request never starting and eventually timing
> out. This is because some drivers combine offchannel requests if
> they are on the same channel and this ultimately results in the
> netlink ACK coming after the ROC started event. This patch fixes
> some logic to allow for this case.

Kernel ROC APIs have no enforcement of semantics at all.  Different drivers just 
do whatever.  Have you tested that this works on brcmfmac for example?  It might 
be better to explicitly wait for the ROC event to be ended before starting a new 
one.

> 
> The motivation to support this is so modules can start offchannel
> work items for short durations and wait for a response, if a frame
> is received the offchannel request can be canceled/restarted for
> a longer duration.
> 
> This could also be done instead by using a long duration initially
> and an extra timer to cancel, but its more convenient if offchannel
> supports this natively. In addition, this driver quirk should be
> supported regardless (e.g. if two IWD modules happen to issue ROC's
> on the same channel).

Then shouldn't offchannel serialize such requests?

> 
> Furthermore, the offchannel module was only looking up requests by
> wdev_id which could result in the wrong request being found.
> Instead the request should be looked up by both wdev_id and cookie
> (when possible), or the ID in the case of canceling.

This part makes sense and probably belongs in a separate patch.

> ---
>   src/offchannel.c | 55 ++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 48 insertions(+), 7 deletions(-)
> 

Regards,
-Denis

