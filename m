Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978A7488
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 15:57:17 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id i3so1992098pfc.11
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2PhbUM6pi43VVcaE4oD1fmYmNtGuwNVlSgPFS9BHCOc=;
        b=h37Spnfk/YJ8WNLR4W/YVA40s/+tfi4gaFmbg5zsKIGVy9OJyUddpTha4bsjOolWwX
         o6I7z8v4UgyQzfBawyFoQnT6yOBL2yiQrLMLmMwU5bvBGuoovyfxMVrosFvzxjBImvt/
         oQmfc40wPwsqDDYq4TgaUBdPcvpoUsZ+uzZwEeFtLsVMn5sNONTTqYMPyJUYDbt5drXN
         cByx7R/S6/jaCClB+rt4S7uxo6ftBzSu/XUB9qNaLHXWk1cPevMJe7sfhkFEUVUFsGgF
         /ZoMGNmzZCUF3oWEq5EjG9tcyNaoF1Bf/QBEGqj51P1AFjid2k40XlEw5yiEHioWynVS
         Ke9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PhbUM6pi43VVcaE4oD1fmYmNtGuwNVlSgPFS9BHCOc=;
        b=cVISoU+6LYHUO1/wAaau6cNFt8Vtjx8h0Bq9SC/AZ0hDCpEi1WCyzPOiYrQ03PQzPR
         EuWh3Q7QFNOj82C+nRzcZRxmXqHvniJ27OqkOdl525ugpgxr8oo4jKhf7AuVueK4PlUB
         e0H1guSWnlc2HwbT6GiuqXgsa2pEnEMSCf32Ff2cmmLLzK4fXOBYi2g4aVi7OVFkBExl
         82McdJBlRW5A7wqcEHzvZHZFczkcRoYJoTcthEmwIOMnXFsxcOkf3cJYuB/o1xLUC1Pt
         jQk9Ccx33ZtNVxlt8ufF4KS7bWdhh6PGmF2tSOPlZGCB5ytnIzduz3Pm2dhECvpJtqT4
         NNaw==
X-Gm-Message-State: ACrzQf0eVl2+9WiXQPqtrbu2VXh+QsY72R5QwRequpnzk9vSAI8UTsR3
	+GvdGcPmYGEoONs27pGza2e+F+cqxQd2/G/AnrDMv/SCJYrG8Q==
X-Google-Smtp-Source: AMsMyM4/ouilcoVfsnWDl827I8Ii7RrlUZDwkGD02EegAClPfOc5SywTyaFH2iCGSGlSu735n6ZPd7TasKxVcLYxWEE=
X-Received: by 2002:a65:6e0d:0:b0:42d:707c:94ee with SMTP id
 bd13-20020a656e0d000000b0042d707c94eemr26136870pgb.260.1667491036541; Thu, 03
 Nov 2022 08:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221103105639.8289-1-andrea@pappacoda.it> <CAGTBY+uDse4b5KzLmVN1Xx5w6bnYAgzT+hO9GPxzavP-8UiHeA@mail.gmail.com>
 <5X3SKR.2RJQXQUUD6QA@pappacoda.it>
In-Reply-To: <5X3SKR.2RJQXQUUD6QA@pappacoda.it>
From: Rhys Perry <rhysperry111@gmail.com>
Date: Thu, 3 Nov 2022 15:56:49 +0000
Message-ID: <CAGTBY+t3E9p44FPhJu9k5QuDX2EzdxV85ipscNFJFq3_xQBcDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] netconfig: add global MulticastDNS option
To: Andrea Pappacoda <andrea@pappacoda.it>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Nov 2022 at 15:48, Andrea Pappacoda <andrea@pappacoda.it> wrote:
>
> Il giorno gio 3 nov 2022 alle 14:23:57 +00:00:00, Rhys Perry
> <rhysperry111@gmail.com> ha scritto:
> > Since we're getting a global setting for mDNS, would it make sense to
> > add a global setting for DNS at the same time too?
>
> I'm not sure about this. Setting a default system-wide DNS server is
> already possible by other means (by editing /etc/resolve.conf,
> modifying systemd-resolved options, etc.).

This doesn't seem to work, as systemd-resolved will let the DNS server
passed from IWD have precedence over its configured default server.
systemd-resolved can take over /etc/resolve.conf (with its own stub)

> Also, overriding the DNS
> server received via DHCP can create issues, and I wouldn't feel
> comfortable in enabling such a setting for all of my networks.

Fair enough, although I feel some users like myself, who quite often
connect to untrusted networks, would like the option to be able to
avoid blindly trusting the DNS server provided through DHCP (without
having to manually configure the setting for new networks they join
and don't trust). I would certainly prefer to be able to set a global
DNS, and then override that in the cases that it causes problems (e.g.
captive portals).
