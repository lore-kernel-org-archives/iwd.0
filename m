Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D0A955
	for <iwd@lists.linux.dev>; Wed, 24 May 2023 14:11:53 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5304913530fso312755a12.0
        for <iwd@lists.linux.dev>; Wed, 24 May 2023 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684937513; x=1687529513;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/vGSb2jJA5xK1Md58QimMI8i0/7IFUXLLAQ3ryZaow=;
        b=FDQerzYx+oplsKS9y4MNee0Ei4RlLjTqAfJ93ccPV2faTtjUwSC6Nmc4QbGX1w7gXP
         6NDc2J/HFebRYvfKqlOIbE60U+VuT8OiLSTJ67DziatsMtMN3kckjLXHzODDne+Jw9HO
         FwUlCekIt4Ld8KNoSarQYcnQhQPQ36W0QWKBj64rdP2RYUikFplNDdOpC+xISVXUmPRA
         1dIqzUt13vhD4kkOKbqSQ2aJVaeSxaDEohw0xHihELwvb9mLmhZC/DfMjwWWBzgHzwBe
         9Yw32rYOb0pM8zb5yTCNbiIZtAwF5PmZFSGW+06HzKGTDLics7rcFM2jDtDm1ygGFqEx
         PFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937513; x=1687529513;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/vGSb2jJA5xK1Md58QimMI8i0/7IFUXLLAQ3ryZaow=;
        b=PK2sVHsMlFn4fby4c30jCsLNBF8fyRUBUCOSCuFhki4vMi3id8cTgltfEj95jGP3g2
         qPwSDqyfj8blArKH9iRTQCisBy7egtTA+mN1NiTMUVUP8n49Y43qQRnIQLzd/kss9Ko0
         7x9EsENMwc0Tlyyo3esXSrK/6ijsuki03c3ig5JX5y3hgSgrAoRDXwEmWZWOJY9kgZQQ
         yPYosvRKEFLpJcBK4YeHsllu45cqlzAmN1eeQFL/hE5/u4rwto1tlmVt/Z7dVCaa7ppo
         kHVHR7Z4zg8G7Fj3BIqcxqDkXqIRVTp1BMdayvGjmtpaOfg0CVE66NlrGN+QjjjuH1dM
         SqBQ==
X-Gm-Message-State: AC+VfDymFjkgsUZ8mWNbqeq1BLod3+HBxTzFKn5zUgT9Br7cTQQyDsFK
	kEv+7FjWFUDwpSaxI9wTjmk=
X-Google-Smtp-Source: ACHHUZ4ebGDbuj/swt0CK/r9n3DrVVZF0muBQJCxdMEj7/FxG9YQkzNYv5cdV6J4pA0GbbwXnGa/9w==
X-Received: by 2002:a17:90b:374c:b0:255:9038:fe0d with SMTP id ne12-20020a17090b374c00b002559038fe0dmr6906030pjb.38.1684937512649;
        Wed, 24 May 2023 07:11:52 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id fs11-20020a17090af28b00b0025368c90773sm1380914pjb.34.2023.05.24.07.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:11:52 -0700 (PDT)
Message-ID: <fcc1f156-95d3-d66f-af64-1cce5db653b6@gmail.com>
Date: Wed, 24 May 2023 07:11:50 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Enable access-point feature
Content-Language: en-US
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <cfee44d1ada44a0c85ab52bfcfba80c6@kelio.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <cfee44d1ada44a0c85ab52bfcfba80c6@kelio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/24/23 12:14 AM, clement.legoffic@kelio.com wrote:
> Hello,
> 
> I develop a simple software to discuss with iwd using DBus to do simple task such as Connect/Disconnect/Scan/Enable AP
> The fact is that, the iwd version brings by package manager is 1.26 and I cannot get the Access Point API.
> So I have tried to compile a more recent version of IWD (the one tagged 2.4)  and the access point API doesn't appear too.
> I didn't find any information if it is a feature only available using --enable-FEATURE
> In the documentation it is said that it is an experimental feature, but I don't know how to activate it.

AP mode has been around since 2017, I think even within the first public 
release (0.1).

> 
> So how to get this API available ?

Starting an AP requires you set the adapter mode to AP which is done 
using the "Mode" property on the Device interface. After that an 
AccessPoint DBus interface should appear. Doing it with iwctl:

$ iwctl device <wlan> set-property Mode ap
$ iwctl ap <wlan> start MySSID secret123

Thanks,
James

> 
> Thanks,
> 
> Clément
> 
> 
> 
> Ce message et toutes les pieces jointes (ci-apres le "message") sont etablis a l'intention exclusive de ses destinataires.
> Si vous recevez ce message par erreur, merci de le detruire et d'en avertir immediatement l'expediteur par e-mail.
> Toute utilisation de ce message non conforme a sa destination, toute diffusion ou toute publication, totale ou partielle, est interdite, sauf autorisation expresse. Les communications sur Internet n'etant pas securisees, l'expediteur informe qu'il ne peut accepter aucune responsabilite quant au contenu de ce message.
> This mail message and attachments (the "message") are solely intended for the addresses. It is confidential in nature.
> If you receive this message in error, please delete it and immediately notify the sender by e-mail.
> Any use other than its intended purpose, dissemination or disclosure, either whole or partial, is prohibited except if formal approval is granted. As communication on the Internet is not secure, the sender does not accept responsibility for the content of this message.
> 
