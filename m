Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5533CD8
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyV4cwnM"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso1043643fac.0
        for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700843003; x=1701447803; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ1EcARaQXxK+esnUy1sS0EAm3dpvY42N3K1BOtL1Mw=;
        b=ZyV4cwnMETC1DvZG6uocVcl2MBURvIJTSL5vfiflkfThx/OO76qx7cIQ8Iza6siFe9
         B3CV+wlHLoLYNIigpwqGiW3dQH5KsWbQWFrb61mhggON/vZvODGoVijdbIUT7Mkmtdq/
         2L43hSFGhQp4sur1TMu5iSnxng0k1bjAcaxS5rcV6rAUmymvjsFt6bKbwLqxoL5bTBaW
         H1jlfe8NJnUu4bTVh4CcIoyfyiAYtsOPlS8BC/xtdMTP9FjYI8j6ayj7Mi8XN2uObWK1
         kL8BUday/e0n1KqhhmzCmRo5MyI1eXxu7R7RI4mzodWE08Ep1cUMY92/vf6gcnRhXHgb
         Brkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843003; x=1701447803;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ1EcARaQXxK+esnUy1sS0EAm3dpvY42N3K1BOtL1Mw=;
        b=dAOeE5Nvh8sywdvDge7vGBs3hx3qddgcO73ML+XgrU7ysUvkMncgn7/JgmJu6/GGjy
         kVrzxCnRUPWYA5u0kI+wbZJu2OR5x1F/PktaAbkckWwj5Rdji4Zmt4OKnhy4JQS6/SGt
         u7m/UU6dz4pLVC8j7ka/vOgnIGNFiSUFVDYkkmGOw1ebGgpLaGiTJMgmgZqOZp6F26XY
         8K295mR3ODeU+JhZFGzo06b7+LKjfTxUK5a2ey74Rv2NB6ecl3QWujNb0B+Wr3QL5ZR2
         5eW2ll+vjAlgy73Og+EDl2qTceuz/yBF3zHn71u0rMntLQeacPnn3BLGUeKdHxT8JleC
         XoEA==
X-Gm-Message-State: AOJu0YxMQAwpgxk5+sH4Wi08HYQhODrAmJMsyZbemqZO1n/hfPD784xf
	y2TWeMr7TLU96ozWZ+q9Sc0f0NpyjPM=
X-Google-Smtp-Source: AGHT+IG4cd3hrEB/kaZoaxafrh8wN81tw+CINnuj0K6wi0AfaEB+CBNrYuZ7ODOcxGdyW2oaeYB8ng==
X-Received: by 2002:a05:6870:3286:b0:1e9:d1b8:5d5a with SMTP id q6-20020a056870328600b001e9d1b85d5amr3808339oac.39.1700843002795;
        Fri, 24 Nov 2023 08:23:22 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h14-20020a056830164e00b006ce2e1a6cb2sm556808otr.44.2023.11.24.08.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:23:22 -0800 (PST)
Message-ID: <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com>
Date: Fri, 24 Nov 2023 10:23:21 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wrong source MAC for DHCP requests with
 AddressRandomization=network
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 iwd@lists.linux.dev
References: <87fs0ve52l.fsf@toke.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <87fs0ve52l.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Toke,

On 11/24/23 05:58, Toke Høiland-Jørgensen wrote:
> Hi
> 
> When setting AddressRandomization=network in main.conf, I am unable to
> connect to networks because I don't get a DHCP reply after the L2
> connection.
> 
> Looking at a packet dump, it seems the DHCP request uses the wrong
> source MAC in the request:
> 

Can you try the following patch on the ell mailing list?  Here's the patchwork 
link in case you're not subscribed:
https://patchwork.kernel.org/project/ell/patch/20231124161740.1243946-1-denkenz@gmail.com/

Regards,
-Denis
