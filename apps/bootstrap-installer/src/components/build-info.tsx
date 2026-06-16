import { useStore } from '@nanostores/react'
import { $buildInfo } from '../store'

export default function BuildInfoFooter() {
  const buildInfo = useStore($buildInfo)

  if (!buildInfo) return null

  return (
    <footer className="pointer-events-none absolute inset-x-0 bottom-0 z-20 flex justify-center px-4 pb-4">
      <div className="max-w-full rounded-full border border-border/60 bg-background/88 px-4 py-2 text-center text-[11px] leading-tight text-muted-foreground shadow-sm backdrop-blur-sm">
        <span className="font-medium text-foreground/80">Installer {buildInfo.version}</span>
        <span className="mx-2 text-border">•</span>
        <span>{buildInfo.commit}</span>
        <span className="mx-2 text-border">•</span>
        <span>{buildInfo.builtAt}</span>
      </div>
    </footer>
  )
}
