Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB266116
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 13:57:44 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-643990c5319so4104401b3a.2
        for <iwd@lists.linux.dev>; Tue, 09 May 2023 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683640664; x=1686232664;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8ZrOET2rUuaOIGJhMycTmt9Vampgb+YP5nHl/ljj7Y=;
        b=f1Mi2wzxYjG7a+pS2W6tpdltWY9/CdIzCOfgOinEx11kLDgLnD+j65dQffece+Sj0h
         P6SduEz2M/3xWqjDGe0dkAsxbc90bA/07jnXKRufbxB7ORU3O91aHYtTRWxQpYccc0Nq
         sTYYqdc8yB+9shpXxF4+UMnjkgsnKfgBoij9PRJYhrRYeCjzM6aTeUzu1/DDvxrCEiUf
         plBzmvonWtzmQNpW9XekOu6djHSTpqkk2MGKBvIxd8xAoyCO5zhCgsM9JjeYh83OsHLw
         pcJUdvYAxz9k2JBnchkkdEeXO07cUqe01Ft+aSFwEMYzJ9lo5omJy4pRXfCS8Mw7QxDI
         ilmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683640664; x=1686232664;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8ZrOET2rUuaOIGJhMycTmt9Vampgb+YP5nHl/ljj7Y=;
        b=Iv4rvwpGkRvu60jiqhfciq/7Fj0dFxE6pjXVAx2AJAVBMYdFPZ1CKqHOsq3FEK9Qjc
         Bdi8iu1jX0GmEDmp4pjUm7k+IsQk+ErLMBPYm0/ssUcqWuV2EsWSdEoDWnG615NGMpq1
         DYwjWl9gERDVzke6pDr/QBxJBc3h/cBV09fUsgioT+aeS+vY6TddWuCChhVK/U0644uz
         ykNCaw+KQW8ZUVyonjU35HDvPV1fMNRkcH3RznUPV0p9SbI9BKaFJyyASByNU5gIyrRZ
         T0tkZJocQNG37pL4HsDhq+2qrbUfTSz/QzfP3YBQeYwb61FMLQRY3L3G13ZivWUWv/pU
         u9rQ==
X-Gm-Message-State: AC+VfDwx5aZYJVfaf5fLZ5+OWD1s5hCEnxeebrZJqiY1keKX4SK4hyxj
	fBEE3DUTndfR8vfVghEWnOHYKdIaonib+g==
X-Google-Smtp-Source: ACHHUZ6jxvCLzKt/Rx1qsKzBvS3bXXxSm44rZ00FPMaU3mbe+j4e/Xw+SxVhA+QEAjwUKvD1wzLOtQ==
X-Received: by 2002:a05:6a00:22d4:b0:643:558d:9ce2 with SMTP id f20-20020a056a0022d400b00643558d9ce2mr20223366pfj.21.1683640663297;
        Tue, 09 May 2023 06:57:43 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id e13-20020a62aa0d000000b00625d84a0194sm1798493pff.107.2023.05.09.06.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 06:57:42 -0700 (PDT)
Message-ID: <119648c7-318b-6ff3-1f04-02d6525c7059@gmail.com>
Date: Tue, 9 May 2023 06:57:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Object path last number
Content-Language: en-US
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <e1a347d59c344b928c1e9150048f9d87@kelio.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e1a347d59c344b928c1e9150048f9d87@kelio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Clement,

On 5/9/23 6:15 AM, clement.legoffic@kelio.com wrote:
> Hi,
> 
> I am trying to interface a dynamic dbus client to the IWD dbus interface for simple commands such as GetOrderedNetworks() or Scan().
> The thing is that the object path of those methods starts with "/net/connman/iwd/" followed by the phy (I only have one interface so I guess it will be 0) and then a number.
> As I want to be dynamic I try to restart iwd to try to observe a specific pattern in the last number of this object path. I have observe that this number is incremented by one at each restart of the iwd service.
> But I saw this number jumping  (by 5 sometimes).
> 
> So I was wondering If I want to call the Scan method, how can I get the correct number for the object path dynamically ?

The last number is actually the interface index, but the path itself 
isn't something you need to worry about deriving yourself. Instead you 
can use the org.freedesktop.DBus.ObjectManager interface and 
GetManagedObjects() method. This returns all the object paths and 
interfaces for IWD.

If your working with Python you can check out IWD's test framework as a 
guide:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/autotests/util/iwd.py#n1143

Thanks,
James

> 
> Thanks
> 
> Clément
> 
> 
> Ce message et toutes les pieces jointes (ci-apres le "message") sont etablis a l'intention exclusive de ses destinataires.
> Si vous recevez ce message par erreur, merci de le detruire et d'en avertir immediatement l'expediteur par e-mail.
> Toute utilisation de ce message non conforme a sa destination, toute diffusion ou toute publication, totale ou partielle, est interdite, sauf autorisation expresse. Les communications sur Internet n'etant pas securisees, l'expediteur informe qu'il ne peut accepter aucune responsabilite quant au contenu de ce message.
> This mail message and attachments (the "message") are solely intended for the addresses. It is confidential in nature.
> If you receive this message in error, please delete it and immediately notify the sender by e-mail.
> Any use other than its intended purpose, dissemination or disclosure, either whole or partial, is prohibited except if formal approval is granted. As communication on the Internet is not secure, the sender does not accept responsibility for the content of this message.
> 
