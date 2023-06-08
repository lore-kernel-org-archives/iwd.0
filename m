Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405113ACD
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 14:18:15 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b01bd7093aso3373835ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Jun 2023 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686233895; x=1688825895;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkKEHaQRDqmHyR1BGiDEBbGhP6JFeqrF/nujX/pbWIs=;
        b=XmSjw0qZEdLS1SJ6gy/b70UVawroAs/m5Mo61hcR0EP0GE0O+XBnV6YE7EU1ZMqVbI
         6ymj5ZgMJuW2rGqvwbPq2l7JFJ057KDEmSBd37gsFa3pF5k7+YdvBI4H9aDkwmZH2dCB
         ZkO/5dXctBdwZGQagIQwKYDNFnu6MBLH9FAxdKguAux0jGtDZzCbav1gJbuQWV61L5xx
         yHNPfD5+IRu5bkwlB3gFru4rAGVnUqJHe4b3Y3a5C6xzzC4+84M/9SdPLo28qz7DtFwr
         Xl4AhxHKGMBVbuDRnUcEji0+Akl1ux35R85Xf313z1c9lWtHQg0n3LA/V4YacAAxjNRM
         dEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686233895; x=1688825895;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkKEHaQRDqmHyR1BGiDEBbGhP6JFeqrF/nujX/pbWIs=;
        b=d6vPQD7Q3emtc26mWqPrVgiHwQNqDy943UZMDYl/c6/zlaIjMmXpnSfl4s1UNm2Zks
         5HwAeyJeuBz1iIuZcjA21kiNpkdKAjztNgsVSTjl+Pr5Fvh7CSj+5HQDqEvwbsHxlQsA
         G4DNAfAhv8uotGL8ppQtYrBNK54rmwocAeQ2Xe5zogTkSmtVpAIXQiQ3D9KeG9f/8MIE
         4Z8S9smZTc5XlhwFk7xfV30mdlxsDz6gLH+9Qx5zSjoENdfuqqHNm5MNru3FXsZW6jzk
         QO9oJ4Rs3HCuTVncgNN1GHcY0pWD23Z/FyKEajmdOWl86pLrBECIMAmycogmINqSLFy/
         Sfgg==
X-Gm-Message-State: AC+VfDynSEmZTNFFNmOgrSD3ev2YYCZzY0iY7vqqp3iu58c7w93GLqUX
	6lvX7mR/jllalsKVZX47Rlo=
X-Google-Smtp-Source: ACHHUZ5OqUNPE19NSLLrEOaeAnNAsroIEaW6mVzlI0n1mlI63wzz0hy3EYz0O0J3xn1oWzNlSR1SZQ==
X-Received: by 2002:a17:902:b104:b0:1b0:7c3c:31ed with SMTP id q4-20020a170902b10400b001b07c3c31edmr4276858plr.25.1686233894566;
        Thu, 08 Jun 2023 07:18:14 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id ju20-20020a170903429400b001ac8cd5ecd6sm1511338plb.65.2023.06.08.07.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 07:18:14 -0700 (PDT)
Message-ID: <fdcd4f17-2b9a-3eee-934c-ce820b805cf7@gmail.com>
Date: Thu, 8 Jun 2023 07:18:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: IWD Not Starting anymore
Content-Language: en-US
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <032bbeb106b34730939e1e605425af5b@kelio.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <032bbeb106b34730939e1e605425af5b@kelio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Clement,

On 6/8/23 6:58 AM, clement.legoffic@kelio.com wrote:
> Hello,
> 
> I am using iwd on an embedded target for simple task for a while: connection, disconnection, scan.
> Version 1.25
> I don't use systemd.
> For a while, it has been working well with PSK and EAP-TLS.
> But now, I can't even start iwd. Here is the debug output :
> 
> root@target ~> /usr/libexec/iwd -d
> Wireless daemon version 1.25
> src/main.c:main() Using configuration directory /etc/iwd
> src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
> src/main.c:nl80211_appeared() Found nl80211 interface
> src/module.c:iwd_modules_init()
> station: Network configuration is disabled.
> src/wsc.c:wsc_init()
> Module hotspot failed to start: -2
> src/module.c:iwd_modules_exit()
> src/wsc.c:wsc_exit()
> D-Bus disconnected, quitting...
> 
> I don't understand its new behaviour.
> The /etc/iwd/main.conf is empty.
> Am I doing it wrong ?
> Do you have any lead ?

So the "Module hotspot failed to start" is because either there is no 
/var/lib/iwd/hotspot directory or the permissions were such that IWD 
could not call opendir().

So check that directory and see. I suspect permissions because IWD will 
create that directory if it doesn't exist.

> 
> Thanks in advance,
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
