Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295C1DA5F
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E30Xq2BD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a7c08b7744so10058897b3.3
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697815510; x=1698420310; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rK99MtDC4DHseKs1UhB06Om+LEWL7pAwbs6GAohVQ/E=;
        b=E30Xq2BDuYl0s/Mvf54WTlAeYrM+71Y2fBtU8XgKdkEMf3u76XwcUWceTASiG251xu
         3F61+vv6NJ4mzrRmsiQj++OFxEp5xhw/0Vq9y7GgyE6Y2e5JfuTjmepeWoIbgB+7hfLn
         Bz9eNNY4ogm2kMaQOFVsvqbE/idJcMc6poj1esU8fYSDoVEPBMeQFv3TITNbS5TbsusK
         WlTfto1WIoQEFgtb5ioz8U3zOoriotEaItS6em6vBFx5rEpz7vPbJ6NfKvGdYq41GR7+
         3IcI453/CzkNiYYWOEQbH89/4lx3BN3g5QxzI7yqwXrilJY86o0rtegV+F1K8HqsNR8H
         8z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815510; x=1698420310;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rK99MtDC4DHseKs1UhB06Om+LEWL7pAwbs6GAohVQ/E=;
        b=LSAnAB2Jn1WiGqurotTq24KUEk1Qq2Cjf/OBnzIoW4X4SQJX5Oi2wa6vYBiyCuTMD/
         QAM8WC7hMF8ZMn6m2ViH7cOCAmEb54VMjO444i4kKg8oQa0YR53QZTZiKJMOUtGikljQ
         nhdYHU5AzPBCY8ZhkUSeDkyIE9VOW2O+KNZxdcnalXZ1j9fOM+7wPohj5XKukw3fhdn7
         uoeyQMgbimodBNYTi0AwL5CpN3vEzm9/ioB+r5wizchvy8L/KvR/YZrJfIYYIHJPN0EM
         XlCE9H3WQq9wt81YPpZo3ht4ABhDqmD0kRpMNB4o1xXQU8TdVM24uQ19gUS5n9n/jY7O
         u+hQ==
X-Gm-Message-State: AOJu0YznwgGloh+3HC2lOLYCobHe3kY2nu4efZnvhvpMWYCKM76nqaRp
	bkn0dipLJDDl3/eIXBH2EoV9CVgYgug=
X-Google-Smtp-Source: AGHT+IFto1U25DUZD3wCNeh3h63+ZkBGr9qODPAHSzBQ/et0k07AZX7e9LopgRjRvoajKylIgscptg==
X-Received: by 2002:a81:6d01:0:b0:5a7:afcc:80fe with SMTP id i1-20020a816d01000000b005a7afcc80femr2395283ywc.3.1697815510632;
        Fri, 20 Oct 2023 08:25:10 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ch13-20020a05622a40cd00b004198f248e8dsm672331qtb.76.2023.10.20.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:25:10 -0700 (PDT)
Message-ID: <3686a908-6230-4ca6-9c1c-0699f2ebd579@gmail.com>
Date: Fri, 20 Oct 2023 08:25:08 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: install iwd-decrypt-profile
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231003192456.4038590-1-prestwoj@gmail.com>
 <a8885dd9-eeff-4318-b7c9-5f54a3273913@gmail.com>
 <095e9190-adf5-47cb-8d8d-78c2a46b8f63@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <095e9190-adf5-47cb-8d8d-78c2a46b8f63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/23 8:19 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/20/23 07:52, James Prestwood wrote:
>> Resending in case this got missed.
>>
> 
> Didn't Marcel reply to this:
> https://lore.kernel.org/iwd/F6D1FD48-E7AC-404B-936A-E4D5E3519FA2@holtmann.org/

Sure enough... it must have got filtered to spam. Thanks.

> 
> Regards,
> -Denis
