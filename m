Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2040DF52
	for <iwd@lists.linux.dev>; Tue,  5 Sep 2023 20:13:23 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3aa139a0ab2so2172474b6e.2
        for <iwd@lists.linux.dev>; Tue, 05 Sep 2023 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693944802; x=1694549602; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxGN8QbElgcf2kJY8g+M7JoMoeRhWjxmMeOHmPKZXv0=;
        b=Db3zjMmaUejNZW+oI340Psgukxi1Ks3VoDYnPICW8OnBGxE+xczRneSoAF2xbmxxy9
         wzbLUJc1HGWf7SJdjEAp2YYLDJxDTnO2WS0p11KhoRXnPTLr3xmPwa5NP9zyN7oU1e3A
         wCx6VwBxgJUWplcysm83z8aUJJjZxVXrPbh9s+KzNECeY7WoIdcnmGLOGa7lVRlZyekK
         qSWBOHGUILK6DMBLr/NyGQi1nv+5s83LcXxAroIe4791FRSMCKfw5ozXiIEdRPo957mL
         PY72vS7/vnwZvZhkRFbl+yZRALp3k0ptROmEj1znj2nPhezv07RuOfl7/cwC16fZYxnq
         DymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944802; x=1694549602;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rxGN8QbElgcf2kJY8g+M7JoMoeRhWjxmMeOHmPKZXv0=;
        b=HdcXDfCW4lj8cb16BCOBtTl/vAl+ztA2LuD9ob6/a5yngl50cbOYjxcT0gdgIrjYD8
         aRAMLvhQE9TNwLAJQsE5r6SD7DqDgkUjaf7Wzefum03hCv25W1ZMBsmkE7FPnJRk/q3R
         PrXlZsOAFhdzkheVoB8Eq3ZgFWg/Qb3ZwPseTtTaKKT/4ZVFMMuyZLguVYgB0WiWCb9R
         kFZZO6kkgKsku32+NKKsVfvP4Nj5MakcYlkh4wTm5a3BI3UpwGG0QwPDdGJelH834g6S
         yfo8yMLfqSl2YA5rqURwshHvbL+5kUItzfgtkNB/HUtrxnsLLd6fR9I7CQk5mtVp6KuB
         YmlQ==
X-Gm-Message-State: AOJu0YzeuSdnSh4wiPhPCI9Yk2otcFvaorXsyn3mlqvTJ5UoDOdTHQY4
	ace3L8dWJ3y/fB30Rlfa0leELmza+Qg=
X-Google-Smtp-Source: AGHT+IF7Sg6px+jGQrEJY5T0pS0GgjH1hHN6GSPWxqZgC6atWCGuDMBTW5sqHF7zTY8lLHMvRsfZUQ==
X-Received: by 2002:a05:6808:1446:b0:3a7:2524:6d3b with SMTP id x6-20020a056808144600b003a725246d3bmr16438823oiv.12.1693944802225;
        Tue, 05 Sep 2023 13:13:22 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e128-20020a0df586000000b00559f1cb8444sm3365653ywf.70.2023.09.05.13.13.21
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:13:22 -0700 (PDT)
Message-ID: <ef6c60ef-8abc-4304-a757-d1acf9f9908e@gmail.com>
Date: Tue, 5 Sep 2023 13:13:19 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: James Prestwood <prestwoj@gmail.com>
Subject: Reworking the default SAE group
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

The current WPA3/SAE logic (really inside ELL) returns a descending list 
of SAE groups which IWD tries. Currently just groups 20 and 19. This 
ordering was initially chosen because higher order groups have larger 
keys are are more secure. I can't come close to speaking to all AP 
manufacturers but I haven't come across a single one that supports group 
20. Even the default openWRT build only supported group 19. In addition 
some APs are even out of spec and don't handle the group negotiation 
correctly, requiring IWD to special case those OUIs.

So at this point it feels (to me) like using group 20 first just a 
performance hit, and should maybe be on an opt-in basis or we should 
explore other options. We could add an option to use a certain group 
which could even be set automatically per-network if the AP rejected 
with status 77 and a subsequent authentication using group 19 succeeded. 
 From that point on the known working group would be used and avoid 
repeated retries.

I'd like to get anyone else's thoughts/experiences on this. Maybe I'm 
wrong about group 20 being widely unsupported? If you use WPA3 check 
your dmesg logs for status 77 errors :)

Thanks,
James
