Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721812B91
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 14:24:45 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7575fc62c7aso465875185a.0
        for <iwd@lists.linux.dev>; Wed, 10 May 2023 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683728685; x=1686320685;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1cjmZgfIAse7dEyO6R5AccvHYi8hgyhmO/Jeyj/RaQ=;
        b=lvV7HAowX0edUUq9YKZJFsR8wI3YdmFzsNtLhWupQjPMF3QYFlSpsC+mCmjjMyGLbK
         EVvcysQXg0X/n57TagYRLPRAmKBc7+thneOCW6SYx56qRcslDgaadI3KQTwFMD5fS4pS
         IeSCjmbhvAvs+aF+YhGyF+ThWcc5mznIo6DI3cyXDtM4huUOGu4wyjG1erqBPpRjRZxc
         THs3vouqKG4zG1fmY31DkOXagrSJ46wR3gNvHutktuM1tUqnVhOal3DH7l/TlQC9rZZw
         11wnJ0Eg9ld5usw/NGj2trYQOolEzsObZ72ZguCpxkQXJtZHCyVURTw19Wz+3bRRiBVD
         uV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728685; x=1686320685;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1cjmZgfIAse7dEyO6R5AccvHYi8hgyhmO/Jeyj/RaQ=;
        b=YOJLy6F66wxhBa95RRycDUOQwrGZYuoizf71NCKEeE6/4lX0mFk/LzD791ARfXPLtE
         JyzY1BFzt1EGB9KH/j96U2rmNi0HicPLBbgujWSrM6IRC2X7KFlFBovZQ6NpFTbrV+pU
         Nta/WkPwjqeMdHPel+FIki/vfoR0uOgXnXEnKoqIy27a3NMtZTznotU/0E2P1IHe2MLZ
         1Jcc5CzA/NoZ2aBCFOTunDrAY3a5xk6A83hPuYtSZeGpKC00xFHpldKWMsF5fMTQo+h7
         3RBBCkcz4bPFcnVe3t2Fks/BLvudGpgUUPeOF0nA/LdQ0tma7b5Mbe8OXJsH39sfDobK
         WNNw==
X-Gm-Message-State: AC+VfDxxWDLh4lgOzhHwvYGpv0F6mx17yg+qlV+WqhExMoobBTzPbKw0
	IK18UyExIXOuf6y6MarbeYCxrYrfeyU=
X-Google-Smtp-Source: ACHHUZ6o0vHZd2jOKwyxDzy6zmzmPK2+Wzvh2wwv2yyZb0xzTwrNUYSvISBJkPVinb3XRKEfwJChMg==
X-Received: by 2002:a05:6214:2421:b0:5a2:abf1:7d33 with SMTP id gy1-20020a056214242100b005a2abf17d33mr27754662qvb.50.1683728684733;
        Wed, 10 May 2023 07:24:44 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id p10-20020a0ce18a000000b006041dae6844sm1563362qvl.96.2023.05.10.07.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:24:44 -0700 (PDT)
Message-ID: <aa25d901-db21-7c8e-92bc-276c452539f3@gmail.com>
Date: Wed, 10 May 2023 07:24:42 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: end scan event
Content-Language: en-US
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <8cbcd21611474bdaadd76652d756c21b@kelio.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8cbcd21611474bdaadd76652d756c21b@kelio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Clement,

On 5/10/23 6:40 AM, clement.legoffic@kelio.com wrote:
> Hi,
> 
> I am currently writing a DBUS client to IWD in c using glib to do simple tasks such as Scan() or GetOrderedNetworks().
> For the scan purpose I wanted to know if IWD does provide an end scan event or signal ?

The station interface has a "scanning" property you can check. For iwctl 
we listen for PropertyChanged signals to get notified.

> 
> 
> Clément
> 
> 
> 
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
