Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD886385
	for <iwd@lists.linux.dev>; Tue,  8 Aug 2023 05:02:20 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bca857accbso4505953a34.0
        for <iwd@lists.linux.dev>; Mon, 07 Aug 2023 22:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691470939; x=1692075739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlHCYLw379SU1b6wTbWRXSauKA8bW1I6ny02nSxMyUU=;
        b=RvRMR/aqKJ3VawQFu09Y41UrgvajwQBe1Q9KLe0MOSbiUCjEH8tjj0dkTPRi1Mycqy
         hwMvoKCLe7LpbJoJD+diInoBz2CuNHz0GJj6opzJxqzmjSrC2nqJ/mnt+b4A7BouZVgC
         rCe0b/Z8G+PuUpaB489p7BGU3Eryu8TGGzxU4dlJObTeigPi/CsoU0j4rDSi33L6qKil
         31GL9ex2Pa8tZ7eVF+bdjaplbbIM4/123TPqINTmNcfX6H8k/I8KQMYSVR6XRpe7+pY1
         AVc7Q1QSsEl2F+NsVJGntToNE8dJmJFbzTIkZ+tz/NJ6C7zVsAqUX7TFib+GDgUKMXmf
         cG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691470940; x=1692075740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlHCYLw379SU1b6wTbWRXSauKA8bW1I6ny02nSxMyUU=;
        b=au39qxcMgtUl8OIfsWUxKAoKLLq9aFs4R1venEUspnH/RmCLe0JgD2WVqUQ2tlI1bQ
         koDl2dgsKeXIgz1BcVeIclZJcpqwgI/OCIFybYBwbSoac5kdTpF9MKzWc0tmVC7PhhAh
         LrrwIL28UNh4Vuz/CRpabyVN3TFiz9lI2ANsEbxKZyTtcB4oEPZPIgpUQIW37yarHlaq
         S4J7/S/EoCnzjJ3j8mCQF4uBMWb070kUkMFsW+7pRwPbr6zHTjpODb/fHbOt6NQa6/ET
         ChqsNHFPk3KHC8JkHmwT6Uwka4lxh6TPH+Ej/A14uEuJFuz7VTHJ84p1+8B7OxLgSdlS
         CDKA==
X-Gm-Message-State: AOJu0Yw62fnFSKqB0KrfoekL/eQgFXYQRtTCpxy3W1Thi0uff8b2zLul
	jmLicKMKzlIW+wZHnojcimI=
X-Google-Smtp-Source: AGHT+IE/KTiYMKd8EM4lu5gceU/IpJO5Km94f6vTRlf7aP91ktJp5xVqtaLBglmBOtu2Ye1tMQLK4Q==
X-Received: by 2002:a05:6830:1386:b0:6b8:dcd2:8b9e with SMTP id d6-20020a056830138600b006b8dcd28b9emr10546864otq.7.1691470939631;
        Mon, 07 Aug 2023 22:02:19 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d5-20020a056830044500b006b96384ba1csm5534996otc.77.2023.08.07.22.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:02:19 -0700 (PDT)
Message-ID: <c64c6250-6666-11b7-2530-240ecd89a1ef@gmail.com>
Date: Tue, 8 Aug 2023 00:02:17 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: doc: APRanges is deprecated (use APAddressPool instead)
Content-Language: en-US
To: "Altous, Salahaldeen" <Salahaldeen.Altous@leica-camera.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Cc: James Prestwood <prestwoj@gmail.com>
References: <AM7PR01MB6724106B9A0D096464D1DFA4AD09A@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <AM7PR01MB6724106B9A0D096464D1DFA4AD09A@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salahaldeen,

On 8/4/23 07:53, Altous, Salahaldeen wrote:
> Hi James,
> 
> I have updated from iwd-1.13 to iwd-2.3 and I was wondering why the APRanges is 
> not working (in main.conf). After checking the source code, I have noticed that 
> APRanges is deprecated, and I have to use APAddressPool.
> The doc is outdated.
> 

I went ahead and applied this patch.  Please note that we prefer patches to be 
sent via git send-email and not as attachments.

Regards,
-Denis

